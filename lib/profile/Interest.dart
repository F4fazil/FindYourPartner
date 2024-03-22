import 'package:chatapp/profile/Search_frendz.dart';
import 'package:chatapp/widgets/mainButton.dart';
import 'package:flutter/material.dart';
import '../Animatedsnackbar/AnimatedSnackbar.dart';
import '../DatabaseStroage class/Database.dart';
import '../constant.dart';
import '../widgets/actionButton.dart';
import 'InterestRow.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}
class _InterestState extends State<Interest> {
  bool isTap = false;
  final List<Color> _containerColor = [Colors.white, Colors.white];
  final List<String> _hobbies = [
    "Photography",
    "Shopping",
    "Music",
    "Gym",
    "Swimming",
    "Books",
    "Travelling",
    "Cooking",
    "Art",
    "Video games"
  ];
  final List<IconData> _icons = [
    Icons.camera,
    Icons.shopping_cart,
    Icons.music_note,
    Icons.fitness_center,
    Icons.pool,
    Icons.book,
    Icons.airplanemode_active,
    Icons.local_dining,
    Icons.palette,
    Icons.videogame_asset,
  ];
   List<String> selectedInterests=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // Handle skip button
                    },
                    child: Text(
                      "Skip",
                      style: title,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Your Interests",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "               Select a few of your interests to let everybody know            \n                        what you are passionate about.",
            ),
            const SizedBox(
              height: 5
            ),
            // Your RowInterest widgets go here

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _hobbies.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    child: RowInterest(
                      text: _hobbies[index],
                     icon:_icons[index]
                    ),
                    onTap: (){
                      setState(() {
                        if (selectedInterests.contains(_hobbies[index])) {
                          selectedInterests.remove(_hobbies[index]);
                        } else {
                          selectedInterests.add("hi");
                        }
                        print("Selected interests length: ${selectedInterests.length}");
                        print("Selected interests are: $selectedInterests");
                      });
                     // _changeColor(index);

                    },
                  );
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width/1.8,
                child: Mybutton(ontap: () {
                  uploadInterest(selectedInterests);
                showSnackBar(context, "Interest", "Successfully save to your profile ");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SearchFrendz()));

                }, buttonname: 'Save',),
              ),
            )
            // Continue with the rest of your widgets
          ],
        ),);
  }
  // void _changeColor(int index) {
  //   if (isTap == false) {
  //     setState(() {
  //       ColorManager().changeColor(_containerColor, index);
  //       isTap = true;
  //     });
  //   } else {
  //     setState(() {
  //       _containerColor[index] = Colors.white;
  //       isTap = false;
  //     });
  //   }
  // }
  uploadInterest(List<String> temp) async {
    print("Uploading interests: $temp");
    print("Selected interests length: ${temp.length}");
    await DataBaseStorage().addData_interest(temp);
  }


}
