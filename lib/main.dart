import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter/model/API/Product/cubit/campaigns_cubit.dart';
import 'package:stylish_flutter/model/API/Product/cubit/product_cubit.dart';
import 'package:stylish_flutter/model/API/Product/product_object.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STYLiSH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productCubit = ProductsCubit();
    final campaignsCubit = CampaignsCubit();
    return Scaffold(
      appBar: const StAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 190,
            child: BlocProvider<CampaignsCubit>(
              create: (context) => campaignsCubit,
              child: BlocBuilder<CampaignsCubit, FetchState>(
                builder: (context, state) {

                  switch (state.runtimeType) {
                  case FetchInitialState: return const Center(child: Text('初始狀態'));

                  case FetchLoadingState: return const Center(child: Text('資料讀取中'));
                  
                  case FetchErrorState:

                    final errorState = state as FetchErrorState;

                    return Center(child: Text(errorState.errorMsg));

                  case FetchSuccessState<List<Campaign>>:

                    final campaigns = ((state as FetchSuccessState).data as List<Campaign>);

                    final imageUrls = campaigns.map((e) => e.picture).toList();

                    return BannerListView(imageUrls: imageUrls);

                  default: return const Center(child: Text('未知問題'));
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: BlocProvider<ProductsCubit>(
              create: (context) => productCubit,
              child: BlocBuilder<ProductsCubit, FetchState>(
                builder: (context, state) {
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    switch (state.runtimeType) {
                      case FetchInitialState: return const Center(child: Text('初始狀態'));

                      case FetchLoadingState: return const Center(child: Text('資料讀取中'));

                      case FetchErrorState:

                        final errorState = state as FetchErrorState;

                        return Center(child: Text(errorState.errorMsg));

                      case FetchSuccessState<List<ProductEntity>>:
                        final products = (state as FetchSuccessState).data;
                        final womenProducts = Products(
                            title: '女裝',
                            products: products
                                .where((product) => product.category == 'women')
                                .toList());
                        final menProducts = Products(
                            title: '男裝',
                            products: products
                                .where((product) => product.category == 'men')
                                .toList());
                        final accessoryProducts = Products(
                            title: '配件',
                            products: products
                                .where((product) =>
                                    product.category == 'accessories')
                                .toList());

                        final List<Products> productsList = [
                          womenProducts,
                          menProducts,
                          accessoryProducts
                        ];

                        return constraints.maxWidth < 700
                            ? MobileLayout(productsList: productsList)
                            : DesktopLayout(productsList: productsList);

                      default: return const Center(child: Text('未知問題'));
                    }
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StAppBar extends StatelessWidget with PreferredSizeWidget {
  const StAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 242, 244, 248),
      title: Image.asset("assets/images/STYLiSH.png",
          fit: BoxFit.cover, height: AppBar().preferredSize.height / 3),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key, required this.productsList});

  final List<Products> productsList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getProductTitleAndCardViews(productsList),
    );
  }

  List<Widget> getProductTitleAndCardViews(List<Products> productsList) {
    final List<Widget> widgets = [];

    productsList.asMap().forEach((index, list) {
      widgets.add(ProductTitleView(listTitle: list.title ?? ''));

      for (var product in list.products) {
        widgets.add(ProductCardView(
          product: product,
        ));
      }
    });

    return widgets;
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.productsList});

  final List<Products> productsList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          productsList.length,
          (index) => TitledCategoryListView(
                title: productsList[index].title ?? '',
                index: index,
                productsList: productsList,
              )),
    );
  }
}

class TitledCategoryListView extends StatelessWidget {
  const TitledCategoryListView(
      {super.key,
      required this.title,
      required this.index,
      required this.productsList});

  final String title;
  final int index;
  final List<Products> productsList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: [
      ProductTitleView(listTitle: title),
      Expanded(
          child: Container(
        width: (MediaQuery.of(context).size.width -
                10 * (productsList.length - 1)) /
            productsList.length,
        padding: const EdgeInsets.only(left: 10),
        child: ProductListView(
          productList: productsList[index].products,
        ),
      ))
    ]));
  }
}

class ProductTitleView extends StatelessWidget {
  const ProductTitleView({
    super.key,
    required this.listTitle,
  });

  final String listTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Text(
        listTitle,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required this.productList});

  final List<ProductEntity> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductCardView(product: productList[index]);
      },
    );
  }
}

class ProductCardView extends StatelessWidget {
  const ProductCardView({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(product: product, productID: "${product.id}")));
      },
      child: SizedBox(
        child: Card(
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(children: [
            Container(
              width: 70,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0))),
              margin: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  child: CachedNetworkImage(
                           imageUrl: product.mainImage,
                           placeholder: (context, url) => const CupertinoActivityIndicator(),
                           errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title),
                  const SizedBox(height: 5),
                  Text('NT\$ ${product.price}')
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class BannerListView extends StatelessWidget {
  const BannerListView({
    super.key,
    required this.imageUrls,
  });

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index) {
        return BannerImageView(index: index, imageUrls: imageUrls);
      },
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    super.key,
    required this.index,
    required this.imageUrls,
  });

  final int index;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
      )
    );
  }
}
