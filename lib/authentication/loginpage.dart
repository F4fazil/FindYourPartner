import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:chatapp/Animatedsnackbar/AnimatedSnackbar.dart';
import 'package:chatapp/profile/profileDetail.dart';
import 'package:chatapp/welcome%20page/welcome.dart';
import 'package:chatapp/widgets/mainButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/SignupPage.dart';
import '../constant.dart';
import '../widgets/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final email = TextEditingController();
  final password = TextEditingController();
  //signIN
  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      showSnackBar(context, "SignIn", "Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Profile()));
    } on FirebaseException catch (e) {
     showSnackBar(context,"Error",e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),

            const SizedBox(
              height: 50,
            ),
             Icon(Icons.girl,size: 150,color: color,),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sign in to you account",
              style: TextStyle(
                  color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Mytextfield(
                  controller: email,
                  hinttext: 'Email',
                  Obsecuretext: false,
                  icon:  Icon(Icons.mail_sharp,color: color),
                )),
            const SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Mytextfield(
                  controller: password,
                  hinttext: 'Password',
                  Obsecuretext: true,
                  icon:  Icon(Icons.password,color: color),
                )),
            const SizedBox(
              height: 100,
            ),
            Mybutton(ontap: (){
              signIn();
            }, buttonname: "SignIn"),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  'Does not have an account?',
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
                            builder: (context) => const RegisterPage()));
                  },
                  child:  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18,
                        color:color,
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
