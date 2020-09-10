import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sendly_chat/services/database.dart';
import 'package:sendly_chat/services/constants.dart';
import 'package:sendly_chat/services/functions.dart';

class ConversationScreen extends StatefulWidget {
  final String chatId;
  ConversationScreen(this.chatId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageTextEditingController =
      new TextEditingController();
  Stream chatStream;

  Widget ChatList() {
    return Container(
      margin: EdgeInsets.only(bottom: 100.0),
      child: StreamBuilder(
        stream: chatStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data.documents[index].data()["message"],
                        snapshot.data.documents[index].data()["sendByMe"] ==
                            Constants.myName,
                        snapshot.data.documents[index].data()["time"]);
                  })
              : Container();
        },
      ),
    );
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sendByMe": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.setChatMessages(widget.chatId, messageMap);
      messageTextEditingController.text = "";
    }
    print(DateTime.now());
  }

  @override
  void initState() {
    databaseMethods.getChatMessages(widget.chatId).then((value) {
      setState(() {
        chatStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.chatId),
        backgroundColor: Color(0xFF1f1e30),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1f1e30),
      body: Container(
        child: Stack(
          children: [
            ChatList(),
            Container(
                margin: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageTextEditingController,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (val) {
                          return val.isEmpty || val.length < 0
                              ? "Please enter a message"
                              : null;
                        },
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20.0),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color(0xFF373753),
                          hintText: "type a message...",
                          hintStyle: TextStyle(
                            color: Color(0xFFb1b2c4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Color(0xFFd83256),
                      shape: CircleBorder(),
                      onPressed: () {
                        sendMessage();
                      },
                      padding: EdgeInsets.all(16),
                      child: Image.asset('assets/icons/sendly_white.png',
                          width: 25.0),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final int time;

  MessageTile(this.message, this.sendByMe, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        width: MediaQuery.of(context).size.width,
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                message ?? "",
                style: TextStyle(
                    color: Color(0xFF373753),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: sendByMe ? Color(0xFFd83256) : Color(0xFF373753),
                borderRadius: sendByMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Text(
                message ?? "",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ));
  }
}
