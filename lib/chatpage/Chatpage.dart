import 'package:chatapp/chatservice.dart';
import 'package:chatapp/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../profile/ProfileImage/profileImage.dart';
import '../widgets/textfield.dart';

class chatPage extends StatefulWidget {
  final String recieveremail;
  final String reieverId;
  final String username;
  const chatPage(
      {super.key,
      required this.recieveremail,
      required this.reieverId,
      required this.username});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  void sendmsg() async {
    if (_textEditingController.text.isEmpty) {
      return AnimatedSnackBar.rectangle(
        'Fail',
        'Message is empty',
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        duration: const Duration(seconds: 2),
        type: AnimatedSnackBarType.success,
        brightness: Brightness.dark,
      ).show(context);
      //
    }
    if (_textEditingController.text.isNotEmpty) {
      await _chatService.sendmessage(
          widget.reieverId, _textEditingController.text);
      _textEditingController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.username.toString(),
        ),
        leading:const SizedBox(
            width: 40,
            child: ProfileImage()),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildIMsgList(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: _buildinputmsg(),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildIMsgList() {
    return StreamBuilder(
        stream: _chatService.getMessage(
            _firebaseAuth.currentUser!.uid, widget.reieverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            AnimatedSnackBar.rectangle(
              'Error',
              snapshot.error.toString(),
              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
              duration: const Duration(seconds: 2),
              type: AnimatedSnackBarType.success,
              brightness: Brightness.dark,
            ).show(context);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return ListView(
              children:
              snapshot.data!.docs.map((doc) => _buildMsgitem(doc)).toList(),
            );
          }
          return Container();
        });
  }

  Widget _buildMsgitem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    bool isRight = (data["senderid"] == _firebaseAuth.currentUser!.uid);
    var alignment = isRight ? Alignment.bottomRight : Alignment.bottomLeft;
    var backgroundColor = isRight ? sentmsgColor : getmsgColor;
    return Container(
      alignment: alignment,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: backgroundColor,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(1, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          data["message"],
                          style: style,
                        ),
                      )),
                ),
                Text(formattedTime,textAlign: TextAlign.end,),
              ],
            ),
          ),

        ],
      ),
    );
  }


  Widget _buildinputmsg() {
    return Row(
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Mytextfield(
                controller: _textEditingController,
                hinttext: 'Enter a message',
                Obsecuretext: false,
                icon: const Icon(
                  Icons.message,
                  // color: Colors.greenAccent,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: IconButton(
              onPressed: () => sendmsg(),
              icon: const Icon(
                Icons.send,
               // color: Colors.greenAccent,
              )),
        )
      ],
    );
  }
}