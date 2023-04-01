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
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StAppBar(),
      body: Column(),
    );
  }
}