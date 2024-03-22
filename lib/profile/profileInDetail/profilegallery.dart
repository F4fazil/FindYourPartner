import 'package:chatapp/constant.dart';
import 'package:flutter/material.dart';

import '../../DatabaseStroage class/Database.dart';
import '../ProfileImage/LikeButton/likebutton.dart';

class ProfileGallery extends StatefulWidget {
  const ProfileGallery({super.key});

  @override
  State<ProfileGallery> createState() => _ProfileGalleryState();
}

class _ProfileGalleryState extends State<ProfileGallery> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height / 1.8,
            child: FutureBuilder<Map<String, dynamic>?>(
                future: DataBaseStorage().getData_name_or_age(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Loading.."),
                          CircularProgressIndicator(
                            color: color,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!;
                    if (data != null) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(data["image"]),
                                fit: BoxFit.cover)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return CircularProgressIndicator(
                    color: color,
                  );
                }),
          ),
          SizedBox(
            child: Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 370),
                    width: width,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )),
                    child: FutureBuilder<Map<String, dynamic>?>(
                        future: DataBaseStorage().getData_name_or_age(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Loading.."),
                                  CircularProgressIndicator(
                                    color: color,
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("Error${snapshot.error}"));
                          } else if (snapshot.hasData) {
                            var data = snapshot.data!;
                            var name =
                                data["firstname"] + " " + data["lastname"];
                            var age = data["age"];
                            if (data != null) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        name + ",   " + age,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "Professional model",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "About",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "A professional model is a skilled individual who poses for photographs, walks the runway, or appears in advertisements to promote products or services. They typically maintain a strong physical presence, possess excellent communication skills, and adhere to industry standards of professionalism and reliability",
                                          maxLines: 10,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "Interests",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          "Travelling",
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          "Books",
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          "Swimming",
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          }
                          return const CircularProgressIndicator();
                        }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
