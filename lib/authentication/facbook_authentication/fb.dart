import 'package:chatapp/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class Facbooksignin extends StatefulWidget {
  const Facbooksignin({super.key});

  @override
  State<Facbooksignin> createState() => _FacbooksigninState();
}

class _FacbooksigninState extends State<Facbooksignin> {


  @override
  Widget build(BuildContext context) {
    // FacebookAuth.instance.initialize(
    //   appId: '382842790965236', // Replace with the desired version
    // );

    Future<void> _loginWithFacebook() async {
      try {
        // Perform Facebook Sign-In action
        final LoginResult result = await FacebookAuth.instance.login();

        if (result.status == LoginStatus.success) {
          // Access the access token and user details
          final AccessToken accessToken = result.accessToken!;
          print('Logged in! User ID: ${accessToken.userId}');
        } else {
          print('Failed to log in: ${result.status}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            _loginWithFacebook();

          },
          child: Text("sign in",style: style,),
        ),
      ),
    );
  }
}
