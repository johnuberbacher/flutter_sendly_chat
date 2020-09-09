import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserByUsername(String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: userName)
        .where("name", isLessThanOrEqualTo: userName + "z")
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  setUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  setChatMessages(String chatId, messageMap) {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("conversations")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getChatMessages(String chatId) async {
    return await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("conversations")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChats(String userName) async {
    return await FirebaseFirestore.instance
        .collection("chats")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
