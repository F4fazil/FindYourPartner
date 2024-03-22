import 'package:flutter/material.dart';

import '../constant.dart';
class Mybutton extends StatelessWidget {
  void Function() ontap;
  String buttonname;

   Mybutton({super.key,required this.ontap,required this.buttonname});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.06,
      child: ElevatedButton(
          onPressed: ontap,
          style: ElevatedButton.styleFrom(
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: color)),
            backgroundColor: color,
          ),
          child:  Text(buttonname,
          style:buttontxtstyle,
          )),
    );
  }
}
