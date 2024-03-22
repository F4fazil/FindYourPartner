import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
   double height=0;
   double width=0;
   Color bc;
   Color iconColor;
  final IconData icon;
   LikeButton({super.key, required this.icon,required this.width,required this.height,required this.bc,required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:bc,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(0, 3), // Offset in x and y direction
              ),
            ],
          ),
          height:height,
          width: width,
          child: Center(
            child: Icon(icon,size: 30,color: iconColor,),
          ),
        ),
      ],
    );
  }
}
