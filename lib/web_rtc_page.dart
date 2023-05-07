import 'dart:core';

import 'package:flutter/material.dart';
import 'src/call_sample/call_sample.dart';
import 'src/call_sample/data_channel_sample.dart';
import 'src/route_item.dart';

class WebRTCPage extends StatefulWidget {
  const WebRTCPage({super.key});

  @override
  State<WebRTCPage> createState() => _WebRTCPage();
}

enum DialogDemoAction {
  cancel,
  connect,
}

class _WebRTCPage extends State<WebRTCPage> {
  List<RouteItem> items = [];
  final String _server = 'demo.cloudwebrtc.com';
  // late SharedPreferences _prefs;
  // bool _datachannel = false;
  
  @override
  initState() {
    super.initState();
    // _initData();
    _initItems();
  }

  _buildRow(context, item) {
    return ListBody(children: <Widget>[
      ListTile(
        title: Text(item.title),
        onTap: () => item.push(context),
        trailing: const Icon(Icons.arrow_right),
      ),
      const Divider()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter-WebRTC example'),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              itemCount: items.length,
              itemBuilder: (context, i) {
                return _buildRow(context, items[i]);
              })),
    );
  }

  // _initData() async {
  //   // _prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _server = 'demo.cloudwebrtc.com';
  //   });
  // }

  // void showDemoDialog<T>(
  //     {required BuildContext context, required Widget child}) {
    // showDialog<T>(
    //   context: context,
    //   builder: (BuildContext context) => child,
    // ).then<void>((T? value) {
    //   // The value passed to Navigator.pop() or null.
    //   if (value != null) {
    //     if (value == DialogDemoAction.connect) {
    //       // _prefs.setString('server', _server);
          
    //     }
    //   }
    // });
  // }

  // _showAddressDialog(context) {
  //   showDemoDialog<DialogDemoAction>(
  //       context: context,
  //       child: AlertDialog(
  //           title: const Text('Enter server address:'),
  //           content: TextField(
  //             onChanged: (String text) {
  //               setState(() {
  //                 _server = text;
  //               });
  //             },
  //             decoration: InputDecoration(
  //               hintText: _server,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //                 child: const Text('CANCEL'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(DialogDemoAction.cancel);
  //                 }),
  //             TextButton(
  //                 child: const Text('CONNECT'),
  //                 onPressed: () {
  //                   Navigator.pop(context, DialogDemoAction.connect);
  //                 })
  //           ]));
  // }

  _initItems() {
    items = <RouteItem>[
      RouteItem(
          title: 'P2P Call Sample',
          subtitle: 'P2P Call Sample.',
          push: (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CallSample(host: _server)));
          }),
      RouteItem(
          title: 'Data Channel Sample',
          subtitle: 'P2P Data Channel.',
          push: (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => DataChannelSample(host: _server)));
          }),
    ];
  }
}