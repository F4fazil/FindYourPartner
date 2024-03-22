
import 'package:chatapp/chatpage/Chatpage.dart';
import 'package:chatapp/profile/ProfileImage/profileImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

   final  Collection=FirebaseFirestore.instance.collection("users");
   
  Future<void> deleteUser(String documentSnapshot) async {
    try {
      // Get a reference to the user document
      final DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(documentSnapshot);

      // Delete the document
      await userRef.delete();

      print('User deleted successfully!');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
  Future<void> retrieveUserData(String userEmail) async {
    try {
      // Get the Firestore instance and reference the collection
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query for the specific user document
      QuerySnapshot userSnapshot = await usersCollection
          .doc(userEmail) // Assuming userEmail is the document ID
          .collection('userdata')
          .get();

      // Iterate through documents in the userdata collection
      userSnapshot.docs.forEach((userDataDoc) {
        // Access the data in each document
        Object? userData = userDataDoc.data();

        // Here you can use userData as needed
        print(userData); // Or do whatever processing you need with userData
      });
    } catch (error) {
      print("Error retrieving user data: $error");
      // Handle errors as needed
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Messages",
          ),
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildUserList(),
      ),
    );
  }
  User? user = FirebaseAuth.instance.currentUser;
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: CircularProgressIndicator(color: color,));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount:snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
             // Widget listItem = userListItem(snapshot.data!.docs[index]);
             DocumentSnapshot userData = snapshot.data!.docs[index];
              return Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: userListItem(userData),
              );
            },
          );
        });
  }
  Widget userListItem(DocumentSnapshot document) {
   Map<String, dynamic> data = document.data() as Map<String,dynamic>;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var uid=FirebaseAuth.instance.currentUser?.uid;
    String? name = data['name'] as String?;
   String? userEmail = data["userEmail"] as String?;
    if (firebaseAuth.currentUser?.email!=data["userEmail"] ) {
      return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => chatPage(
                    recieveremail: data["userEmail"],
                    reieverId: data["uid"],
                    username:name.toString(),
                  )));
        },
        leading:ProfileImage(),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0,left: 10),
          child: Text(
            data["name"],
          ),
        ),
        subtitle: const Padding(
          padding: EdgeInsets.only(left: 11.0),
          child: Text("Sent message ✔"),
        ),
      );
    }
    return Container();
  }
}






