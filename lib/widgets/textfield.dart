import 'package:chatapp/constant.dart';
import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hinttext;
  final bool Obsecuretext;
  const Mytextfield(
      {Key? key,
      required this.controller,
      required this.hinttext,
      required this.Obsecuretext, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: Obsecuretext,
      //style:  const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          prefixIcon:icon,
          enabledBorder:  OutlineInputBorder(
              borderSide:  BorderSide(color:showColor, width:1.5),
            borderRadius: BorderRadius.circular(5),

          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: activeColor,width: 2.5),
            borderRadius: BorderRadius.circular(10),
          ),

          filled: true,
          hintText:hinttext),
    );
  }
}
