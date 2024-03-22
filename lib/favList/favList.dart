import 'package:chatapp/DatabaseStroage%20class/Database.dart';
import 'package:chatapp/authentication/loginpage.dart';
import 'package:chatapp/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../profile/ProfileImage/findpplz.dart';

class FavList extends StatefulWidget {
  FavList({Key? key}) : super(key: key);

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  late List<bool> isLikedList;

  @override
  void initState() {
    super.initState();
    isLikedList = []; // Initialize it as an empty list
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Favorite List")),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: DataBaseStorage().getFav(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green.shade200,
                      ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text(
                        'No users found',
                        style: title,
                      ));
                } else {
                  var count = snapshot.data!.length - 1;
                  // Initialize isLikedList with true for each item
                  if (isLikedList.isEmpty) {
                    isLikedList = List.generate(count, (index) => true);
                  }

                  return GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data![index];

                      var _name = data['name'] ?? "";
                      var age = data['age'] ?? "";
                      var img = data['image'] ?? "";
                      return Container(
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(5),
                        height: _height / 6,
                        width: _width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 122,
                                ),
                                IconButton(
                                  onPressed: () {
                                    removeFav(data);
                                    setState(() {
                                      isLikedList[index] = !isLikedList[index];
                                    });
                                  },
                                  icon: Icon(
                                    isLikedList[index]
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                _name,
                                style: name,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                "$age years",
                                style: name,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  removeFav(Map<String, dynamic> userData) {
   DataBaseStorage().deleteFav(userData);
  }
}
