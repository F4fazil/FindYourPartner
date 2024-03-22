import 'package:chatapp/Animatedsnackbar/AnimatedSnackbar.dart';
import 'package:chatapp/MyHomePage.dart';
import 'package:chatapp/chatservice.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/favList/favList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../DatabaseStroage class/Database.dart';
import '../../chatpage/Chatpage.dart';
import '../../theme/themeProvider.dart';
import '../../widgets/actionButton.dart';

class Finpplz extends StatefulWidget {
  Finpplz({Key? key}) : super(key: key);

  @override
  _FinpplzState createState() => _FinpplzState();
}

class _FinpplzState extends State<Finpplz> {
  var _name ;
  var age ;
  var img ;
  var uid ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;

    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0,
              right: 18, top: 8, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ActionButton(),
              const Text(
                "Discover",
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  return CupertinoSwitch(
                    value: themeProvider.isdark,
                    onChanged: (value) => themeProvider.toggle(),
                  );
                },
              ),            ],
          ),
        ),
        SizedBox(
          width: _width,
          height: _height / 1.6,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: DataBaseStorage().getAllUsersData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(
                  color: Colors.green.shade200,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No users found', style: title,));
              } else {
                var count=snapshot.data!.length-1;
                return PageView.builder(

                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data![index];

                     _name = data['firstname'] ?? "";
                     uid=data["uid"];
                     age = data['age'] ?? "";
                     img = data['image'] ?? "";
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          top: 30, left: 35, right: 35),
                      height: _height / 2,
                      width: _width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(img),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 370,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _name,
                              style: name,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "$age years",
                              style: name,
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
        const SizedBox(
          height: 15,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width/1.4,
            height:  MediaQuery.of(context).size.width/8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:ThemeProvider().themedata.dividerColor,

                elevation: 1, // Controls the button's shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Button border radius
                ),
              ),
              onPressed: (){
                uploadFav();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FavList()));



              }, child: const Text("Add to Favourite!",style:TextStyle(
                color: Colors.white70
            )),
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width/1.4,
            height:  MediaQuery.of(context).size.width/8,
            child: ElevatedButton(
             style: ElevatedButton.styleFrom(
                // Add decoration properties here
               backgroundColor: ThemeProvider().themedata.dividerColor,
                elevation: 0, // Controls the button's shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Button border radius
                ), // Button background color
              ),
              onPressed: (){
               ChatService().sendmessage(uid, "Hello!");
               showSnackBar(context, "Message", "Sent successfully");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                    )
                );


              }, child:  const Text("Say Hello!",style:TextStyle(
              color: Colors.white70
            )),
            ),
          ),
        ),
      ],
    );
  }

uploadFav() async {
  if (_name.isNotEmpty && img.isNotEmpty && age.isNotEmpty) {
    Map<String, dynamic> addItem = {
      "image": img,
      "name": _name,
      "age": age,
    };
    showSnackBar(context, "User", "Add to faviourite");
    await DataBaseStorage().addToFav(addItem);
  } else {
    print("failed");
  }
  }
}
