import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:signalr_client/signalr_client.dart';

import '../scoped_models/main.dart';
import '../models/user.dart';
import '../models/message.dart';

class PrivateChat extends StatefulWidget {
  final MainModel model;
  final User user;

  PrivateChat(this.model, this.user);

  @override
  State<StatefulWidget> createState() {
    return _PrivateChatState();
  }
}

class _PrivateChatState extends State<PrivateChat> {
  bool connectionIsOpen = false;
  var connectionId;

  @override
  void initState() {
    widget.model.buildMessageList(widget.user);
    super.initState();
  }

  Widget _buildChatMessage(Message message, bool sender) {
    print('ind _buildChatMessage');
    if (sender) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(message.name),
              Card(
                child: Text(message.message),
              )
            ],
          ),
          CircleAvatar(
              backgroundImage: widget.model.user.hasPicture
                  ? NetworkImage(widget.model.user.picture[0])
                  : AssetImage('assets/images/noPic.png'))
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
            backgroundImage: widget.user.hasPicture
                ? NetworkImage(widget.user.picture[0])
                : AssetImage('assets/images/noPic.png')),
        Column(
          children: <Widget>[
            Text(message.name),
            Card(
              child: Text(message.message),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    List<Message> tempList =messages;
    bool sender = false;
    if (tempList.length < 1) {
      return Text('Ingen besekder endnu');
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (tempList[index].name == widget.model.user.firstName) {
          sender = true;
        }
        print('Building item number: ' + index.toString());
        _buildChatMessage(tempList[index], sender);
      },
      itemCount: tempList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 31, 31),
        title: Text(
          'Chat med ' + widget.user.firstName,
          style: TextStyle(),
        ),
        brightness: Brightness.dark,
      ),
      body: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Center(
            child: Container(
              color: Color.fromRGBO(34, 28, 28, 1),
              child: model.isLoading
                  ? CircularProgressIndicator()
                  : _buildMessageList(model.messages),
            ),
          );
        },
      ),
    );
  }
}
