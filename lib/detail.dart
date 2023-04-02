import 'package:flutter/material.dart';
import 'package:stylish_flutter/model/API/Product/product_object.dart';
import 'main.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});

  final ProductEntity product;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final double contentWidth = 780;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StAppBar(),
      body: SingleChildScrollView(
          child: Column(children: [
        const SizedBox(height: 26),
        Container(
          constraints: BoxConstraints(minWidth: contentWidth),
          height: 600,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/genshin2.jpeg",
                  fit: BoxFit.fill, width: (contentWidth - 10) / 2, height: 600),
              const SizedBox(width: 10),
              SizedBox(
                width: (contentWidth - 10) / 2,
                height: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('UNIQLO 特級極輕羽絨外套', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 5),
                    Text('${20323023}'),
                    SizedBox(height: 20),
                    Text('NT\$ 323', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                  
                ])
              )
            ],
          ),
        )
      ])),
    );
  }
}
