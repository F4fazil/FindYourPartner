
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle style=const TextStyle(
    fontWeight: FontWeight.w900,
    fontSize:  20,
    color: Colors.black
);
TextStyle little=const TextStyle(
    fontWeight: FontWeight.w900,
    fontSize:  15,
    color: Colors.grey
);
TextStyle name = GoogleFonts.poppins(
    textStyle: TextStyle(

      fontWeight: FontWeight.w500,
      // Other text style properties...
    fontSize:18,
    color: Colors.white,

    ),
);
TextStyle title= const TextStyle(
    fontWeight: FontWeight.w900,
    fontSize:  20,
   color: Colors.black
);
TextStyle description=const TextStyle(
    fontWeight: FontWeight.w300,
    fontSize:  17,
    color: Colors.black
);
TextStyle buttontxtstyle=  TextStyle(
    fontWeight: FontWeight.w900,
    fontSize:  20,
    color:buttontxtcolor
);
class AppConstants {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void initialize(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}
Color buttontxtcolor=Colors.white;
Color color=Colors.green.shade300;
Color appbarBackground=Colors.grey.shade200;
Color pickColor=Colors.white;
Color appbarColor=Colors.grey.shade200;
Color showColor=appbarColor;
Color activeColor=Colors.grey.shade300;
Color sentmsgColor=Colors.yellow.shade200;
Color getmsgColor=Colors.cyan.shade200;



