import 'package:chatapp/constant.dart';
import 'package:chatapp/widgets/mainButton.dart';
import 'package:flutter/material.dart';
import '../widgets/actionButton.dart';
import 'Interest.dart';


class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  bool isTap=false;
  final List<Color> _containerColor =[
    Colors.white,
    Colors.white,
    Colors.white,


  ];

  void _changeColor(int index) {
    if(isTap==false){
      setState(() {
       // ColorManager().changeColor(_containerColor, index);
        isTap=true;
      });
    }
    else{
      setState(() {
        _containerColor[index] = Colors.white;
        isTap=false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ActionButton(),
                TextButton(
                    onPressed: () {
                      //
                    },
                    child: Text(
                      "Skip",
                      style: title,
                    )),
              ],
            ),

          ),
          const SizedBox(height: 20,),
          const Text("I am",style:TextStyle(
            fontSize: 30,fontWeight: FontWeight.bold
          ),),
           const SizedBox(height: 70,),
          GestureDetector(
            child:
            Container(
              height: 65,
              width: MediaQuery.of(context).size.width*0.85,
              decoration: BoxDecoration(
                color: _containerColor[0],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black38, width: 0.5),
              ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Man",style: style,),
                   const Icon(Icons.check,size: 20,),

                 ],
               ),
             ),
            ),
            onTap: (){
              _changeColor(0);
            },
          ),
          const SizedBox(height: 23,),
          GestureDetector(
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width*0.85,
              decoration: BoxDecoration(
                color: _containerColor[1],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black38, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Woman",style: style,),
                    const Icon(Icons.check,size: 20,),

                  ],
                ),
              ),
            ),
            onTap: (){
              _changeColor(1);
            },
          ),
          const SizedBox(height: 23,),
          GestureDetector(
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width*0.85,
              decoration: BoxDecoration(
                color: _containerColor[2],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black38, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Choose another",style: style,),
                    const Icon(Icons.arrow_forward_ios,size: 20,),

                  ],
                ),
              ),
            ),
            onTap: (){
              _changeColor(2);
            },
          ),
          const SizedBox(height: 200,),
           Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Mybutton(ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Interest()));
            }, buttonname: 'Continue',),
          ),

        ],
      ),
    );
  }
}
