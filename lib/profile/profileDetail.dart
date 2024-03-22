import 'dart:io';
import 'dart:math';
import 'package:chatapp/Animatedsnackbar/AnimatedSnackbar.dart';
import 'package:chatapp/profile/male_or_female.dart';
import 'package:chatapp/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import '../DatabaseStroage class/Database.dart';
import '../constant.dart';
import '../widgets/actionButton.dart';
import '../widgets/mainButton.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final age = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
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
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text(
                      "Skip",
                      style: title,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Profile Details",
                style: style,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Stack(children: [
              _imageFile == null
                  ? GestureDetector(
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _imageFile!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
            ]),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Mytextfield(
                  controller: firstname,
                  hinttext: "First Name",
                  Obsecuretext: false,
                  icon: Icon(Icons.person, color: color))),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Mytextfield(
                  controller: lastname,
                  hinttext: "Last Name",
                  Obsecuretext: false,
                  icon: Icon(Icons.person, color: color))),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Mytextfield(
                  controller: age,
                  hinttext: "Age",
                  Obsecuretext: false,
                  icon: Icon(Icons.person, color: color))),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Mybutton(
              ontap: () {
                uploadImage(user!.uid.toString());
              },
              buttonname: 'Continue',
            ),
          ),
        ],
      ),
    ));
  }
  uploadImage( String userid) async {
      var id = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("pic").child(id);
      UploadTask upload = firebaseStorageRef.putFile(_imageFile!);
      var downloadurl = await (await upload).ref.getDownloadURL();
      if(downloadurl.isNotEmpty && firstname.text.isNotEmpty && lastname.text.isNotEmpty &&age.text.isNotEmpty){
        Map<String, dynamic> addItem = {
          "image": downloadurl,
          "firstname": firstname.text,
          "lastname": lastname.text,
          "age": age.text,
          "uid":userid,
        };
        navigateToNeXTpAGE();
        showmessage("Saved", "");
        await DataBaseStorage().addData_name_or_age(addItem);
      }
      else{
        showmessage("Error", 'Fill the above blanks');
      }

  }
  showmessage(String title,String text){
    showSnackBar(context, title, text);
  }
  navigateToNeXTpAGE(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Gender()));
  }
}
