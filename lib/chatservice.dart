import 'package:chatapp/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timestamp timestamp = Timestamp.now();

  Future<void> sendmessage(String receiverid, String message) async {
    final currentuserid = _firebaseAuth.currentUser!.uid;
    final currentusergmail = _firebaseAuth.currentUser!.email.toString();
    Message newMessage = Message(
        receiverid, currentusergmail, currentuserid, message, timestamp);

    List<String> ids = [currentuserid, receiverid];
    ids.sort();
    String chatroomId = ids.join("_");
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages").add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userid, String otheruserID) {
    List<String> ids = [userid, otheruserID];
    ids.sort();
    String chatroomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
