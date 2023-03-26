import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final List<String> imageUrls = [
    'genshin1.jpeg',
    'genshin2.jpeg',
    'genshin3.jpeg',
    'genshin4.jpeg',
    'genshin5.jpeg'
  ];

  final categoryTitles = <String>['女裝', '男裝', '配件'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 244, 248),
        title: Image.asset("images/STYLiSH.png",
            fit: BoxFit.cover, height: AppBar().preferredSize.height / 3),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 190,
            child: BannerListView(imageUrls: imageUrls),
          ),
          Row(
            children: List.generate(
              categoryTitles.length,
              (index) => 
              SizedBox(
                width: MediaQuery.of(context).size.width / categoryTitles.length,
                height: 20,
                child:
                  Text(
                   categoryTitles[index],
                   style: const TextStyle(fontWeight: FontWeight.bold),
                   textAlign: TextAlign.center,
                  ),
             )
            ),
          ),
          const ProductCardView(title: '原石', price: 3290,)
        ],
      ),
    );
  }
}

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    super.key,

    required this.title,
    required this.price
  });

  final String title;
  final int price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          width: 300,
          height: 100,
          child: Row(children: [
            Container(
              width: 70,
              height: 100,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Image.asset('images/genshin_stone.jpeg', fit: BoxFit.contain),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, textAlign: TextAlign.left),
                const SizedBox(height: 5),
                Text('NT\$ $price', textAlign: TextAlign.left)
              ],
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
    return SizedBox(
      width: 300.0,
      child: Card(
        margin: const EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Image.asset('images/${imageUrls[index]}', fit: BoxFit.cover),
      ),
    );
  }
}
