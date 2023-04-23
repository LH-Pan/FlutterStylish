
import 'package:flutter/material.dart';


class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});


  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  bool prepared = false;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {

        },
        child: const Text('結帳')
      )
    );
  }
}