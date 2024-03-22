import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chatapp/constant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../authentication/SignupPage.dart';
import '../authentication/loginpage.dart';
import '../model/Model.dart';
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void displaymessage(String message){
    AnimatedSnackBar.rectangle(
      '',
      message,
      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      duration: const Duration(seconds: 2),
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(context);
  }
  @override
  Widget build(BuildContext context) {
    final _width=MediaQuery.of(context ).size.width;
    final _height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: _height/1.4,
            width: _width/1.15,
           // color: Colors.yellowAccent,
            margin: const EdgeInsets.only(top: 40,left: 20),
            child: FutureBuilder(
                future: readData(),
                builder: (BuildContext context, data) {
                  if (data.hasData) {
                    List<DataProductModel> item = data.data!;
                    return PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:item.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Column(
                            children: [
                              Container(
                                height: _height/2.5,
                                margin: const EdgeInsets.only(
                                    left: 22, right: 40, bottom: 20, top: 20),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(item[index].path!),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(height: 60,),
                              Center(child: Text(item[index].name!,style: title,textAlign: TextAlign.center,)),
                              const SizedBox(height: 12,),
                              Text(item[index].des!,style:description ,),

                              const SizedBox(height: 12,),
                              DotsIndicator(
                                dotsCount: 3,
                                position: index,
                                decorator: DotsDecorator(
                                  activeColor:
                                  Colors.purple,
                                  size: const Size.square(7),
                                  activeSize: const Size(10, 10),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                ),
                              ),
                            ],
                          ),
                    );
                  } else if (data.hasError) {
                     displaymessage(data.error.toString());
                  }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child:
            SizedBox(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.06,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterPage()));

                  },
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: color)),
                    backgroundColor: color,
                  ),
                  child: const Text(
                    'Create an account',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  )),
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(
                width: 10,
              ),
              const Text(
                'Already have an account?',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child:  Text(
                  'Login Now',
                  style: TextStyle(
                      fontSize: 16,
                      color: color,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
  Future<List<DataProductModel>> readData() async {
    String jsonData =
    await DefaultAssetBundle.of(context).loadString('data/data.json');
    List temp = json.decode(jsonData);
    List<DataProductModel> dataproducmodel = temp
        .map((dataproducmodel) => DataProductModel.fromJson(dataproducmodel))
        .toList();
    return dataproducmodel;
  }
}
