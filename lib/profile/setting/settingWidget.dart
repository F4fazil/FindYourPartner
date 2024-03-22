import 'package:flutter/material.dart';
class SettingRow extends StatelessWidget {
  String text;
  IconData icon;



   SettingRow({super.key,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5,left: 0,bottom: 5),
      child:
      Container(
        height: 80,
        width: MediaQuery.of(context).size.width*0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 20,),
                 Icon(icon),
                const SizedBox(width: 15,),
                Text(text)
              ],
            ),
            const Icon(Icons.arrow_forward_ios,size: 17,),
          ],
        ),
      ),
    );
  }
}
