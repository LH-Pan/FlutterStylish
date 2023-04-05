import 'package:flutter/material.dart';
import 'package:stylish_flutter/model/API/Product/product_object.dart';
import 'main.dart';
import 'extension/widget_extension.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});

  final ProductEntity product;

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
      body: SingleChildScrollView(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth < desktopContentWidth
            ? MobileLayout(contentWidth: mobileContentWidth, product: widget.product)
            : DesktopLayout(contentWidth: desktopContentWidth, product: widget.product);
      })),
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    super.key,
    required this.contentWidth,
    required this.product
  });

  final double contentWidth;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainImageView(contentWidth: contentWidth, mainImageUrl: product.mainImage).addPadding(top: 26, bottom: 20),
          SelectionOfItemsView(contentWidth: contentWidth, product: product).addPadding(bottom: 10),
          StoryWithImagesView(contentWidth: contentWidth, story: product.story, imageUrls: product.images)
        ],
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    super.key,
    required this.contentWidth,
    required this.product
  });

  final double contentWidth;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainImageView(contentWidth: (contentWidth - 10) / 2, mainImageUrl: product.mainImage),
          const SizedBox(width: 10),
          SelectionOfItemsView(contentWidth: (contentWidth - 10) / 2, product: product,)
        ],
      ).addPadding(bottom: 15, top: 26),
      StoryWithImagesView(contentWidth: contentWidth, story: product.story, imageUrls: product.images)
    ]);
  }
}

class SelectionOfItemsView extends StatelessWidget {
  const SelectionOfItemsView({
    super.key,
    required this.contentWidth,
    required this.product
  });

  final double contentWidth;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: contentWidth,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)).addPadding(bottom: 5),
        Text('${product.id}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 20),
        Text('NT\$ ${product.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)).addPadding(bottom: 5),
        const Divider(color: Color.fromARGB(255, 210, 208, 208), thickness: 1).addPadding(bottom: 5),
        Row(children: [
          const Text('顏色', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(right: 5),
          Container(
            width: 1,
            height: 16,
            color: const Color.fromARGB(255, 210, 208, 208)
          ).addPadding(right: 10),
          Container(
            width: 16, 
            height: 16,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 4, 44, 6),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0.5, 0.5))]
            )
          ).addPadding(right: 10),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 38, 104),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0.5, 0.5))]
            ),
          )
        ]).addPadding(bottom: 20),
        Row(children: [
          const Text('尺寸', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(right: 5),
          Container(width: 1, height: 16, color: const Color.fromARGB(255, 210, 208, 208)).addPadding(right: 10),
          Container(
            width: 30,
            height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 93, 93),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0, 1))]
              ),
              child:const Text('S', style: TextStyle(color: Colors.white))
          ).addPadding(right: 10),
          Container(
            width: 30,
            height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 93, 93),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0, 1))]
              ),
              child: const Text('M', style: TextStyle(color: Colors.white))
          ).addPadding(right: 10),
          Container(
            width: 30,
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 94, 93, 93),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0, 1))]),
              child: const Text('L', style: TextStyle(color: Colors.white)
            )),
        ]).addPadding(bottom: 30),
        Row(children: [
          const Text('數量', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(right: 5),
          Container(width: 1, height: 16, color: const Color.fromARGB(255, 210, 208, 208)).addPadding(right: 10),
          Expanded(
            child: Row(children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                  child: const Icon(Icons.remove, color: Colors.white)
                )
              ).wrapWithExpanded(),
              const Text('1', textAlign: TextAlign.center).wrapWithExpanded(flex: 2),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                  child: const Icon(Icons.add, color: Colors.white)
                )
              ).wrapWithExpanded()
          ]))
        ]).addPadding(bottom: 20),
        Row(children: [
          TextButton(
            onPressed: () {}, 
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              backgroundColor: const Color.fromARGB(255, 48, 48, 48)
            ),
            child: const Text(
              '請選擇尺寸',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20)
            ).addPadding(bottom: 20, top: 20)
          ).wrapWithExpanded()
        ]).addPadding(bottom: 10),
        Text(product.note, style: const TextStyle(fontSize: 16)).addPadding(bottom: 8),
        Text(product.texture, style: const TextStyle(fontSize: 16)).addPadding(bottom: 8),
        Text(product.description, style: const TextStyle(height: 1.8, fontSize: 16)).addPadding(bottom: 8),
        Text('素材產地 / ${product.place}', style: const TextStyle(fontSize: 16)).addPadding(bottom: 8),
        Text('加工產地 / ${product.place}', style: const TextStyle(fontSize: 16)).addPadding(bottom: 8),
    ]));
  }
}

class MainImageView extends StatelessWidget {
  const MainImageView({
    super.key,
    required this.contentWidth,
    required this.mainImageUrl
  });

  final double contentWidth;
  final String mainImageUrl;

  @override
  Widget build(BuildContext context) {

    return Image.network(
      mainImageUrl, 
      fit: BoxFit.fill, 
      width: contentWidth
    );
  }
}

class StoryWithImagesView extends StatelessWidget {
  const StoryWithImagesView({
    super.key,
    required this.contentWidth,
    required this.story,
    required this.imageUrls
  });

  final double contentWidth;
  final String story;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: contentWidth,
        child: Column(children: [
          Row(children: [
            const Text('細部說明', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)).addPadding(right: 20)
            .addGradientWith(
              BlendMode.srcIn,
              const Color.fromARGB(255, 48, 59, 213),
              const Color.fromARGB(255, 13, 232, 243),  
              Alignment.centerLeft, 
              Alignment.centerRight
            ),
            const Divider(color: Colors.grey, thickness: 1.5).wrapWithExpanded()
          ]).addPadding(bottom: 5),
          Text(story, style: const TextStyle(height: 1.5, fontWeight: FontWeight.w500))
        ] + addImageViewsWith(imageUrls, contentWidth)));
  }

  List<Padding> addImageViewsWith(List<String> imageUrls, double width) {

    return imageUrls.map((imageUrl) => 
      Image.network(
          imageUrl,
          width: width,
          fit: BoxFit.fitWidth,
        ).addPadding(top: 15)
    ).toList();
  }
}
