import 'package:flutter/material.dart';

import '../constant.dart';
class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black38, width: 1),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 22,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
