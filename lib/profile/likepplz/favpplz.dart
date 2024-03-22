import 'package:flutter/material.dart';

import '../../DatabaseStroage class/Database.dart';
import '../../constant.dart';
import '../../widgets/actionButton.dart';

class favpplz extends StatelessWidget {
  const favpplz({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 18.0, right: 18, top: 8, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Matches",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle skip button
                  },
                  icon: Icon(
                    Icons.menu_rounded,
                    size: 30,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "            This is list of people who have liked\n                    you and your matches.",
                style: little,
              ),
            ],
          ),



          SizedBox(
            width:_width,
            height: _height /1.3,
            child: FutureBuilder<Map<String,dynamic>?>(
              future: DataBaseStorage().getData_name_or_age(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return const Text('Data not available');
                }
                else{
                  var data = snapshot.data!;
                  // Access data fields dynamicall
                  var age = data['age'];
                  var firstname=data["firstname"];
                  var lastname=data["lastname"];
                  var image=data["image"];
                  return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of pictures per row
                    crossAxisSpacing: 0, // Spacing between pictures horizontally
                    mainAxisSpacing:0, // Spacing between rows vertically
                  ),
                    itemCount:10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10,),
                        // height: _height ,
                        // width: _width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          image:  DecorationImage(
                              image:NetworkImage(image),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 102,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    firstname+", "+age,
                                    style: name,
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){

                                  },
                                  icon: const Icon(Icons.favorite_border_outlined,size: 20,color: Colors.grey,),
                                )
                              ],
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


}
