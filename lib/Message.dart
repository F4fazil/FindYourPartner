import 'package:cloud_firestore/cloud_firestore.dart';
class Message
{
  final String receieverid;
  final String senderGmail;
  final String senderid;
  final String message;
  final Timestamp timestamp;

  Message(this.receieverid, this.senderGmail, this.senderid, this.message, this.timestamp,);

  Map<String,dynamic> toMap(){
    return{
      "receieverid":receieverid,
      "senderGmail":senderGmail,
      "senderid":senderid,
      "message":message,
      "timestamp":timestamp
    };
  }

}