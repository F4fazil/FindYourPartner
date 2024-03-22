import 'package:chatapp/widgets/mainButton.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'ProfileImage/findpplz.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _NotificationState();
}

class _NotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            //const ActionButton(),
            Padding(
              padding: EdgeInsets.only(left: 280),
              child: Expanded(
                child: TextButton(
                    onPressed: () {//
                    },
                    child: Text(
                      "Skip",
                      style: title,
                    )),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 30, left: 35, right: 35),
        height: MediaQuery.of(context).size.height/6,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
              image: AssetImage("data/fonts_pics/msg.JPG"),
              fit: BoxFit.cover),
        ),

      ),
        SizedBox(
          height: 130,
        ),
        Center(
          child: Text(
            "Enable's Notification",
            style: title,
          ),
        ),
        SizedBox(
          height: 9,
        ),
        Center(
          child: Text(
            "       Get push notification when you get match \n                      and recieve a message.",
            style: little,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 140, bottom: 15),
          child: Mybutton(
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Finpplz()));
            },
            buttonname: 'I want to be notified',
          ),
        ),
      ],
    ));
  }
}
