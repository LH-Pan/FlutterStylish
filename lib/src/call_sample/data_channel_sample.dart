import 'package:flutter/material.dart';
import 'dart:core';
import 'signaling.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class DataChannelSample extends StatefulWidget {
  static String tag = 'call_sample';
  final String host;
  const DataChannelSample({super.key, required this.host});

  @override
  State<DataChannelSample> createState() => _DataChannelSampleState();
}

class MessageData {

  final String text;
  final bool isRecived;

  MessageData(this.text, this.isRecived);
}

class _DataChannelSampleState extends State<DataChannelSample> {
  Signaling? _signaling;
  List<dynamic> _peers = [];
  String? _selfId;
  bool _inCalling = false;
  RTCDataChannel? _dataChannel;
  Session? _session;
  _DataChannelSampleState();
  bool _waitAccept = false;
  late BuildContext _dialogContext;

  final TextEditingController _textController = TextEditingController();
  final List<MessageData> _messages = [];

  @override
  initState() {
    super.initState();
    _connect(context);
  }

  @override
  deactivate() {
    super.deactivate();
    _signaling?.close();
    // _timer?.cancel();
  }

  Future<bool?> _showAcceptDialog() {
    return showDialog<bool?>(
      context: context,
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return AlertDialog(
          title: const Text("title"),
          content: const Text("accept?"),
          actions: <Widget>[
            MaterialButton(
              child: const Text(
                'Reject',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            MaterialButton(
              child: const Text(
                'Accept',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showInvateDialog() {
    return showDialog<bool?>(
      context: context,
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return AlertDialog(
          title: const Text("title"),
          content: const Text("waiting"),
          actions: <Widget>[
            TextButton(
              child: const Text("cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
                _hangUp();
              },
            ),
          ],
        );
      },
    );
  }

  void _connect(BuildContext context) async {
    _signaling ??= Signaling(widget.host, context)..connect();

    _signaling?.onDataChannelMessage = (_, dc, RTCDataChannelMessage data) {
      setState(() {
        if (data.isBinary) {
          print('Got binary [${data.binary}]');
        } else {
          _messages.insert(0, MessageData(data.text, true));
        }
      });
    };

    _signaling?.onDataChannel = (_, channel) {
      _dataChannel = channel;
    };

    _signaling?.onSignalingStateChange = (SignalingState state) {
      switch (state) {
        case SignalingState.ConnectionClosed:
        case SignalingState.ConnectionError:
        case SignalingState.ConnectionOpen:
          break;
      }
    };

    _signaling?.onCallStateChange = (Session session, CallState state) async {
      switch (state) {
        case CallState.CallStateNew:
          setState(() {
            _session = session;
          });
          break;
        case CallState.CallStateBye:
          if (_waitAccept) {
            print('peer reject');
            _waitAccept = false;
            Navigator.of(_dialogContext).pop(false);
          }
          setState(() {
            _inCalling = false;
          });
          _dataChannel = null;
          _inCalling = false;
          _session = null;
          break;
        case CallState.CallStateInvite:
          _waitAccept = true;
          _showInvateDialog();
          break;
        case CallState.CallStateConnected:
          if (_waitAccept) {
            _waitAccept = false;
            Navigator.of(_dialogContext).pop(false);
          }
          setState(() {
            _inCalling = true;
          });
          break;
        case CallState.CallStateRinging:
          bool? accept = await _showAcceptDialog();
          if (accept!) {
            _accept();
            setState(() {
              _inCalling = true;
            });
          } else {
            _reject();
          }

          break;
      }
    };

    _signaling?.onPeersUpdate = ((event) {
      setState(() {
        _selfId = event['self'];
        _peers = event['peers'];
      });
    });
  }

  _invitePeer(context, peerId) async {
    if (peerId != _selfId) {
      _signaling?.invite(peerId, 'data', false);
    }
  }

  _accept() {
    if (_session != null) {
      _signaling?.accept(_session!.sid, 'data');
    }
  }

  _reject() {
    if (_session != null) {
      _signaling?.reject(_session!.sid);
    }
  }

  _hangUp() {
    _signaling?.bye(_session!.sid);
  }

  _buildRow(context, peer) {
    var self = (peer['id'] == _selfId);
    return ListBody(children: <Widget>[
      ListTile(
        title: Text(self
            ? peer['name'] + ', ID: ${peer['id']} ' + ' [Your self]'
            : peer['name'] + ', ID: ${peer['id']} '),
        onTap: () => _invitePeer(context, peer['id']),
        trailing: const Icon(Icons.sms),
        subtitle: Text('${'[' + peer['user_agent']}]'),
      ),
      const Divider()
    ]);
  }

  _handleSubmitted(String text) {
    _textController.clear();

    final String trimmedText = text.trim();

    if (trimmedText.isNotEmpty) {
      
      _dataChannel?.send(RTCDataChannelMessage(text));
      setState(() {
        _messages.insert(0, MessageData(text, false));
      });
    }
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(
              controller: _textController,
              decoration:
                  const InputDecoration.collapsed(hintText: "Send a message"),
              onFieldSubmitted: _handleSubmitted,
            ),
          ),
          FloatingActionButton(
            onPressed: () => _handleSubmitted(_textController.text),
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageData messageData) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(messageData.text, textAlign: messageData.isRecived ? TextAlign.start : TextAlign.end),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_selfId != null ? ' [Your ID ($_selfId)] ' : '')),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: null,
            tooltip: 'setup',
          ),
        ],
      ),
      body: _inCalling
          ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (_, int index) =>
                        _buildMessage(_messages[index]),
                  ),
                ),
                const Divider(height: 1.0),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: _buildTextComposer(),
                ),
                const SizedBox(height: 30)
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              itemCount: (_peers != null ? _peers.length : 0),
              itemBuilder: (context, i) {
                return _buildRow(context, _peers[i]);
              }),
    );
  }
}
