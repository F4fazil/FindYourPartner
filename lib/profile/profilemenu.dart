  import 'package:chatapp/DatabaseStroage%20class/Database.dart';
  import 'package:chatapp/constant.dart';
  import 'package:chatapp/profile/profileInDetail/profilegallery.dart';
  import 'package:chatapp/profile/setting/settingWidget.dart';
  import 'package:chatapp/theme/themeProvider.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';

  class ProfileMenu extends StatefulWidget {
    const ProfileMenu({super.key});

    @override
    State<ProfileMenu> createState() => _ProfileMenuState();
  }

  class _ProfileMenuState extends State<ProfileMenu> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Profile "),
          //  backgroundColor: appbarBackground,
          ),
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Expanded(
                  child: FutureBuilder<Map<String, dynamic>?>(
                      future: DataBaseStorage().getData_name_or_age(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Loading.."),
                                Center(
                                  child: CircularProgressIndicator(
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error${snapshot.error}"));
                        } else if (snapshot.hasData) {
                          var data = snapshot.data!;
                          if (data != null) {
                            return Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 20, right: 30, top: 30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 2, color: Colors.white70),
                                          image: DecorationImage(
                                              image: NetworkImage(data["image"]),
                                              fit: BoxFit.cover)),
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 20, right: 30),
                                    child: Text(
                                      data['firstname'],
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                      child: SettingRow(
                                        text: 'Profile',
                                        icon: Icons.person,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProfileGallery()));
                                      }),
                                  SettingRow(
                                    text: 'Premium',
                                    icon: Icons.workspace_premium_sharp,
                                  ),

                                  // SettingRow(text: 'Theme', icon: Icons.nightlight_sharp,),
                                  Container(
                                    height: 80,
                                    width:
                                        MediaQuery.of(context).size.width * 0.95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Icon(Icons.dark_mode,),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text("Dark Mode"),
                                            const SizedBox(
                                              width: 160,
                                            ),
                                            Consumer<ThemeProvider>(
                                              builder:
                                                  (context, themeProvider, _) {
                                                return CupertinoSwitch(
                                                  value: themeProvider.isdark,
                                                  onChanged: (value) =>
                                                      themeProvider.toggle(),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector (
                                    onTap: () { DataBaseStorage().signout();},
                                    child: SettingRow(
                                      text: 'Sign out',
                                      icon: Icons.logout_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          color: color,
                        ));
                      }),
                ),
              ),
            ],
          ));
    }
  }
