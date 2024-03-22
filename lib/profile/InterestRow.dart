import 'package:flutter/material.dart';
import '../constant.dart';

class RowInterest extends StatefulWidget {
  String text = "";
  final IconData? icon;
  RowInterest(
      {super.key,
      required this.text,
      required this.icon,
     });

  @override
  State<RowInterest> createState() => _RowInterestState();
}

class _RowInterestState extends State<RowInterest> {
  bool isTap = false;
  final List<Color> _containerColor = [Colors.white, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.width/6,
            width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
                color: _containerColor[0],
                border: Border.all(color: Colors.black38, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(
                  widget.icon,
                  size: 20,
                  color: color,
                ),
                SizedBox(width: 10,),
                Text(widget.text, style: description),
              ],
            ),
          ),
          onTap: () {
            _changeColor(0);
          },
        ),
        const SizedBox(
          width: 10,
        ),

      ],
    );
  }

  void _changeColor(int index) {
    if (isTap == false) {
      setState(() {
        //ColorManager().changeColor(_containerColor, index);
        isTap = true;
      });
    } else {
      setState(() {
        _containerColor[index] = Colors.white;
        isTap = false;
      });
    }
  }
}
