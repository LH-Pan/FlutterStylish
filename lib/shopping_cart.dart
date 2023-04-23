
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish_flutter/extension/widget_extension.dart';

import 'main.dart';


class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  MethodChannel platform = const MethodChannel('TestMethodChannel');

  String tapPaySetupMsg = '';
  String getPrimeMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StAppBar(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
    
                try {
    
                  final String result = await platform.invokeMethod('setupTappay', {'fuck':'fuckyou'});
    
                  setState(() {
                    
                    tapPaySetupMsg = result;
                  });
                }  catch (e) {
    
                  setState(() {
                    
                    tapPaySetupMsg = "Not「iOS」or「Android」device";
                  });
                }
              },
              child: const Text('Setup Tap Pay')
            )
          ).addPadding(bottom: 20),
          Center(child: Text(tapPaySetupMsg)).addPadding(bottom: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
    
                try {
    
                  final String result = await platform.invokeMethod('getPrime', 
                                                                    {'cardNumber':'4242424242424242',
                                                                     'dueMonth':'01',
                                                                     'dueYear':'24',
                                                                     'ccv':'123'});
    
                  setState(() {
                    
                    getPrimeMsg = result;
                  });
                }  catch (e) {
    
                  setState(() {
    
                    getPrimeMsg = "Not「iOS」or「Android」device";
                  });
                }
              },
              child: const Text('Get Prime')
            )
          ).addPadding(bottom: 20),
          Center(child: Text(getPrimeMsg))
        ],
      ),
    );
  }
}