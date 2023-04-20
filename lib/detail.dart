import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter/model/API/Product/cubit/product_cubit.dart';
import 'package:stylish_flutter/model/API/Product/product_object.dart';
import 'main.dart';
import 'extension/widget_extension.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.product, required this.productID});

  final ProductEntity? product;
  final String productID;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final double desktopContentWidth = 780;
  final double mobileContentWidth = 385;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StAppBar(),
      body: SingleChildScrollView(
          child: widget.product == null
              ? BlocProvider(
                  create: (context) => ProductCubit(id: widget.productID),
                  child: BlocBuilder<ProductCubit, FetchState>(
                    builder: (context, state) {

                      switch (state.runtimeType) {
                      case FetchInitialState: return const Center(child: Text('初始狀態'));

                      case FetchLoadingState: return const Center(child: Text('資料讀取中'));
                      
                      case FetchErrorState:

                        final errorState = state as FetchErrorState;

                        return Center(child: Text(errorState.errorMsg));

                      case FetchSuccessState<ProductEntity>:

                        final product = (state as FetchSuccessState).data as ProductEntity;

                        return LayoutBuilder(builder:
                           (BuildContext context, BoxConstraints constraints) {
                               return constraints.maxWidth < desktopContentWidth
                                    ? MobileLayout(contentWidth: mobileContentWidth, product: product)
                                    : DesktopLayout(contentWidth: desktopContentWidth, product: product);
                      });

                      default: return const Center(child: Text('未知問題'));
                      }
                    },
                  ),
                )
              : LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return constraints.maxWidth < desktopContentWidth
                      ? MobileLayout(
                          contentWidth: mobileContentWidth,
                          product: widget.product ?? ProductEntity.empty())
                      : DesktopLayout(
                          contentWidth: desktopContentWidth,
                          product: widget.product ?? ProductEntity.empty());
                })),
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout(
      {super.key, required this.contentWidth, required this.product});

  final double contentWidth;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainImageView(
                  contentWidth: contentWidth, mainImageUrl: product.mainImage)
              .addPadding(top: 26, bottom: 20),
          SelectionOfItemsView(contentWidth: contentWidth, product: product)
              .addPadding(bottom: 10),
          StoryWithImagesView(
              contentWidth: contentWidth,
              story: product.story,
              imageUrls: product.images)
        ],
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout(
      {super.key, required this.contentWidth, required this.product});

  final double contentWidth;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainImageView(
              contentWidth: (contentWidth - 10) / 2,
              mainImageUrl: product.mainImage),
          const SizedBox(width: 10),
          SelectionOfItemsView(
              contentWidth: (contentWidth - 10) / 2, product: product)
        ],
      ).addPadding(bottom: 15, top: 26),
      StoryWithImagesView(
          contentWidth: contentWidth,
          story: product.story,
          imageUrls: product.images)
    ]);
  }
}

class SelectionOfItemsView extends StatelessWidget {
  const SelectionOfItemsView(
      {super.key, required this.contentWidth, required this.product});

  final double contentWidth;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: contentWidth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18))
              .addPadding(bottom: 5),
          Text('${product.id}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16))
              .addPadding(bottom: 20),
          Text('NT\$ ${product.price}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18))
              .addPadding(bottom: 5),
          const Divider(color: Color.fromARGB(255, 210, 208, 208), thickness: 1)
              .addPadding(bottom: 5),
          ColorSelectorView(
            colors: product.colors, 
            onColorSelected: (colorIndex) {
            
          },).addPadding(bottom: 20),
          SizeSelectorView(
            sizes: product.sizes,
            onSizeSelected: (sizeIndex) {
              
            }).addPadding(bottom: 30),
          const QuantityStepperView(stockLimit: 2).addPadding(bottom: 20),
          Row(children: [
            TextButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: const Color.fromARGB(255, 48, 48, 48)),
                    child: const Text('請選擇尺寸',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20))
                        .addPadding(bottom: 20, top: 20))
                .wrapWithExpanded()
          ]).addPadding(bottom: 10),
          Text(product.note, style: const TextStyle(fontSize: 16))
              .addPadding(bottom: 8),
          Text(product.texture, style: const TextStyle(fontSize: 16))
              .addPadding(bottom: 8),
          Text(product.description,
                  style: const TextStyle(height: 1.8, fontSize: 16))
              .addPadding(bottom: 8),
          Text('素材產地 / ${product.place}', style: const TextStyle(fontSize: 16))
              .addPadding(bottom: 8),
          Text('加工產地 / ${product.place}', style: const TextStyle(fontSize: 16))
              .addPadding(bottom: 8),
        ]));
  }
}

class QuantityStepperView extends StatefulWidget {
  const QuantityStepperView({
    super.key,
    required this.stockLimit
  });

  final int stockLimit;

  @override
  State<QuantityStepperView> createState() => _QuantityStepperViewState();
}

class _QuantityStepperViewState extends State<QuantityStepperView> {
  int quantity = 1;
  bool decreaseDisabled = true;
  late bool increaseDisabled = quantity == widget.stockLimit ? true : false;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text('數量',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
          .addPadding(right: 5),
      Container(
              width: 1,
              height: 16,
              color: const Color.fromARGB(255, 210, 208, 208))
          .addPadding(right: 10),
      Expanded(
          child: Row(children: [
        InkWell(
                onTap: decreaseDisabled ? null : () {
                  setState(() {

                    quantity --;
                    increaseDisabled = false;

                    if (quantity <= 1) {
                      
                      decreaseDisabled = true;
                    } 
                  });
                },
                child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: decreaseDisabled ? Colors.grey : Colors.black),
                    child: const Icon(Icons.remove, color: Colors.white)))
            .wrapWithExpanded(),
        Text('$quantity', textAlign: TextAlign.center)
            .wrapWithExpanded(flex: 2),
        InkWell(
                onTap: increaseDisabled ? null : () {
                    setState(() {

                      quantity ++;
                      decreaseDisabled = false;

                      if (quantity >= widget.stockLimit) {
                      
                        increaseDisabled = true;
                      
                      } 
                    });
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: increaseDisabled ? Colors.grey : Colors.black),
                    child: const Icon(Icons.add, color: Colors.white)))
            .wrapWithExpanded()
      ]))
    ]);
  }
}

class SizeSelectorView extends StatefulWidget {
  const SizeSelectorView({
    super.key,
    required this.sizes,
    required this.onSizeSelected
  });

  final List<String> sizes;
  final void Function(int) onSizeSelected;

  @override
  State<SizeSelectorView> createState() => _SizeSelectorViewState();
}

class _SizeSelectorViewState extends State<SizeSelectorView> {

  int? _selectedSizeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text('尺寸',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
          .addPadding(right: 5),
      Container(
              width: 1,
              height: 16,
              color: const Color.fromARGB(255, 210, 208, 208))
          .addPadding(right: 10),
      for (var index = 0; index < widget.sizes.length; index++)
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedSizeIndex = index;
            });
            widget.onSizeSelected(index);
          },
          child: Container(
                  width: 30,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: index == _selectedSizeIndex ? const Color.fromARGB(255, 237, 232, 232) : const Color.fromARGB(255, 94, 93, 93),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 1,
                            offset: const Offset(0, 1))
                      ]),
                  child: Text(widget.sizes[index],
                      style: TextStyle(color: index == _selectedSizeIndex ? Colors.grey : Colors.white)))
              .addPadding(right: 10),
        ),
    ]);
  }
}

class ColorSelectorView extends StatefulWidget {
  const ColorSelectorView({
    super.key,
    required this.colors,
    required this.onColorSelected
  });

  final List<ColorEntity> colors;
  final void Function(int) onColorSelected;

  @override
  State<ColorSelectorView> createState() => _ColorSelectorViewState();
}

class _ColorSelectorViewState extends State<ColorSelectorView> {

  int? _selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text('顏色',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
          .addPadding(right: 5),
      Container(
              width: 1,
              height: 16,
              color: const Color.fromARGB(255, 210, 208, 208))
          .addPadding(right: 10),
       for (var index = 0; index < widget.colors.length; index++)

        GestureDetector(
          onTap: () {
            setState(() {
              _selectedColorIndex = index;
            });
            widget.onColorSelected(index);
          },
          child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  border: index == _selectedColorIndex ? Border.all(color: Colors.black, width: 1.5) : null,
                  color: Color(int.parse(widget.colors[index].code, radix: 16) + 0xFF000000),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 1,
                        offset: const Offset(0.5, 0.5))
                  ])).addPadding(right: 10),
        ),
    ]);
  }
}

class MainImageView extends StatelessWidget {
  const MainImageView(
      {super.key, required this.contentWidth, required this.mainImageUrl});

  final double contentWidth;
  final String mainImageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: contentWidth,
        fit: BoxFit.fill,
        imageUrl: mainImageUrl,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error));
  }
}

class StoryWithImagesView extends StatelessWidget {
  const StoryWithImagesView(
      {super.key,
      required this.contentWidth,
      required this.story,
      required this.imageUrls});

  final double contentWidth;
  final String story;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: contentWidth,
        child: Column(
            children: [
                  Row(children: [
                    const Text('細部說明',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ))
                        .addPadding(right: 20)
                        .addGradientWith(
                            BlendMode.srcIn,
                            const Color.fromARGB(255, 48, 59, 213),
                            const Color.fromARGB(255, 13, 232, 243),
                            Alignment.centerLeft,
                            Alignment.centerRight),
                    const Divider(color: Colors.grey, thickness: 1.5)
                        .wrapWithExpanded()
                  ]).addPadding(bottom: 5),
                  Text(story,
                      style: const TextStyle(
                          height: 1.5, fontWeight: FontWeight.w500))
                ] +
                addImageViewsWith(imageUrls, contentWidth)));
  }

  List<Padding> addImageViewsWith(List<String> imageUrls, double width) {
    return imageUrls
        .map((imageUrl) => CachedNetworkImage(
            width: width,
            fit: BoxFit.fitWidth,
            imageUrl: imageUrl,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error)).addPadding(top: 15))
        .toList();
  }
}
