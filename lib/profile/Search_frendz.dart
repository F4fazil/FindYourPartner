import 'package:chatapp/profile/Notification.dart';
import 'package:chatapp/welcome%20page/welcome.dart';
import 'package:chatapp/widgets/mainButton.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class SearchFrendz extends StatefulWidget {
  const SearchFrendz({Key? key});

  @override
  State<SearchFrendz> createState() => _SearchFrendzState();
}

class _SearchFrendzState extends State<SearchFrendz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 280),
                child: TextButton(
                  onPressed: () {
                    // Handle skip button
                  },
                  child: Text(
                    "Skip",
                    style: title,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 30, left: 35, right: 35),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage("data/fonts_pics/111.png"),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              "Search's Friends",
              style: title,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Center(
            child: Text(
              "       You can find friends online and \n             from your contact lists.",
              style: little,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140, bottom: 15),
            child: Mybutton(
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomePage()),
                );
              },
              buttonname: 'Search online Friends',
            ),
          ),
        ],
      ),
    );
  }
}
