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
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 26),
        Container(
          constraints: BoxConstraints(minWidth: desktopContentWidth),
          height: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainImageView(contentWidth: desktopContentWidth),
              const SizedBox(width: 10),
              SelectionOfItemsView(contentWidth: desktopContentWidth)
            ],
          ),
        ).addPadding(bottom: 15),
            StoryWithImagesView(contentWidth: desktopContentWidth)
      ])),
    );
  }
}

class SelectionOfItemsView extends StatelessWidget {
  const SelectionOfItemsView({
    super.key,
    required this.contentWidth,
  });

  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (contentWidth - 10) / 2,
        height: 500,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('UNIQLO 特級極輕羽絨外套', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)).addPadding(bottom: 5),
              const Text('${2023032101}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 20),
              const Text('NT\$ 323', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)).addPadding(bottom: 5),
              const Divider(color: Color.fromARGB(255, 210, 208, 208), thickness: 1).addPadding(bottom: 5),
              Row(children: [
                const Text('顏色', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(right: 5),
                Container(width: 1, height: 16, color: const Color.fromARGB(255, 210, 208, 208)).addPadding(right: 10),
                Container(
                  width: 16, 
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 4, 44, 6),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0.5, 0.5))]
                  )).addPadding(right: 10),
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
              Container(width: 30, height: 25, alignment: Alignment.center, decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 93, 93),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0, 1))]
              ), child: const Text('S', style: TextStyle(color: Colors.white))).addPadding(right: 10),
              Container(width: 30, height: 25, alignment: Alignment.center, decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 93, 93),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0, 1))]
              ), child: const Text('M', style: TextStyle(color: Colors.white))).addPadding(right: 10),
              Container(width: 30, height: 25, alignment: Alignment.center, decoration: BoxDecoration(
                color: const Color.fromARGB(255, 94, 93, 93),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 1, offset: const Offset(0, 1))]
              ), child: const Text('L', style: TextStyle(color: Colors.white))),
            ]).addPadding(bottom: 30),
              Row(children: [
               const Text('數量', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(right: 5),
               Container(width: 1, height: 16, color: const Color.fromARGB(255, 210, 208, 208)).addPadding(right: 10),
               Expanded(child: Row(
                children: [
                Expanded(
                 flex: 1,
                 child: InkWell(
                  onTap: (){}, 
                  child: Container(
                    width: 25,
                    height: 25, 
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(
                    Icons.add,
                    color: Colors.white,
                 )))),
                const Expanded(flex: 2, child: Text('1', textAlign: TextAlign.center)),
                Expanded(
                 flex: 1,
                 child: InkWell(
                  onTap: (){}, 
                  child: Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25, 
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    )))),
              ]))
            ]).addPadding(bottom: 20),
              Container(
                alignment: Alignment.center,
                width: contentWidth / 2,
                height: 60,
                color: const Color.fromARGB(255, 48, 48, 48),
                child: const Text(
                    '請選擇尺寸', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(color: Colors.white, fontSize: 20))).addPadding(bottom: 5),
              const Text('實品顏色依照單品照為主', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 5),
              const Text('棉 100%', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 5),
              const Text('厚薄 : 薄', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 5),
              const Text('彈性 : 無', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 5),
              const Text('素材產地 / 日本', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 5),
              const Text('加工產地 / 中國', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)).addPadding(bottom: 5),
            ]));
  }
}

class MainImageView extends StatelessWidget {
  const MainImageView({
    super.key,
    required this.contentWidth,
  });

  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/genshin2.jpeg",
        fit: BoxFit.fill,
        width: (contentWidth - 10) / 2,
        height: 600);
  }
}

class StoryWithImagesView extends StatelessWidget {
  const StoryWithImagesView({
    super.key,
    required this.contentWidth,
  });

  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: contentWidth,
      child: Column(children: [
        Row(children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                 colors: [Color.fromARGB(255, 48, 59, 213), Color.fromARGB(255, 13, 232, 243)],
                 stops: [0.0, 1.0],
                 begin: Alignment.centerLeft,
                 end: Alignment.centerRight,
                 tileMode: TileMode.clamp,
              ).createShader(bounds);
            },
            child: const Text('細部說明',
             style: TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold,
           )).addPadding(right: 20)),
          const Expanded(child: Divider(color: Colors.grey, thickness: 1.5))
        ]).addPadding(bottom: 5),
        const Text('O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy',
          style: TextStyle(height: 1.5, fontWeight: FontWeight.w500),).addPadding(bottom: 15),
        Image.asset('images/genshin1.jpeg', width: contentWidth, fit: BoxFit.fitWidth).addPadding(bottom: 15),
        Image.asset('images/genshin2.jpeg', width: contentWidth, fit: BoxFit.fitWidth).addPadding(bottom: 15),
        Image.asset('images/genshin3.jpeg', width: contentWidth, fit: BoxFit.fitWidth).addPadding(bottom: 15),
        Image.asset('images/genshin4.jpeg', width: contentWidth, fit: BoxFit.fitWidth)
      ])
    );
  }
}
