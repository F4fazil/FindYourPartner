import 'package:chatapp/profile/profileDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Animatedsnackbar/AnimatedSnackbar.dart';
import '../constant.dart';
import '../widgets/mainButton.dart';
import '../widgets/textfield.dart';
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp() async{
    if (passwordTextController.text != confirmPasswordTextController.text) {
      showSnackBar(context, "Password", "Password not match");
      return;
    }
    try {
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);

         makeUserDocument(userCredential);
    }

    on FirebaseException catch (e)
    {
      AlertDialog(
        title: Text('Error found in:${e.code}',style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),),
      );

    }
  }
  Future<void> makeUserDocument( UserCredential? userCredential)async {
      if(userCredential!=null && userCredential.user!=null){
        await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set({
          "name":nameTextController.text,
          "userEmail":userCredential.user!.email,
          "password":passwordTextController.text,
          "uid":userCredential.user?.uid,
        });

      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
             Icon(Icons.girl,color:color,size: 150,),
            const SizedBox(
              height: 5,
            ),
             Text(
              " Sign up to your account ",
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: nameTextController,
                    hinttext: 'Name',
                    Obsecuretext: false, icon:  Icon(Icons.mail,color: color),
                  )),
            ),
             const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: emailTextController,
                    hinttext: 'Email',
                    Obsecuretext: false, icon:  Icon(Icons.mail,color: color,),
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: passwordTextController,
                    hinttext: 'Password',
                    Obsecuretext: true, icon:  Icon(Icons.password,color:color),
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: SingleChildScrollView(
                  child: Mytextfield(
                    controller: confirmPasswordTextController,
                    hinttext: ' Confirm Password',
                    Obsecuretext: true, icon: Icon( Icons.password,color: color),
                  )),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child:Mybutton(ontap: () {
                  signUp();
                showSnackBar(context, "Signup", "Successfully");
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Profile()));
              }, buttonname: 'Sign up',),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 45,
                ),
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child:  Text(
                    'Login Now',
                    style: TextStyle(
                        fontSize: 18,
                        color: color,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
