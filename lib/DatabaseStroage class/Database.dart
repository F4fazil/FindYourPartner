import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class DataBaseStorage {
  //adding item to Firebase
  User? user = FirebaseAuth.instance.currentUser;

  //adding data into name_or_age of currentuser
  Future <void> addData_name_or_age(Map<String,dynamic> profileData)async{
   try{
     await FirebaseFirestore.instance.collection("users").doc(user?.email).set(profileData);
     print(user.toString());
     print("Data added to Firestore successfully! ");
   }catch(e){
     print('Error adding data to Firestore: $e');
   }
  }

  //fetching data from name_or_age of currentuser
  Future<Map<String, dynamic>?> getData_name_or_age() async {
    if (user == null || user?.email == null) {
      print('User information is missing.');
      return null; // Return null if user information is missing
    }

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.email)
        .get();

    if (snapshot.exists) {
      return snapshot.data(); // Extract data from DocumentSnapshot
    } else {
      print('Document does not exist for the current user.');
      return null; // Return null if document does not exist
    }
  }

  Future<void> addData_interest(List<String> profileData) async {
    try {
      await FirebaseFirestore.instance
          .collection("usersProfile")
          .doc("interest")
          .update({'interests': profileData});

      print('Data added to Firestore successfully!');
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
  Future<List<Map<String, dynamic>>> getAllUsersData() async {
    try {
      // Fetch all users except the current user
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("users").get();

      // Filter out the current user's data
      List<Map<String, dynamic>> allUsersData = querySnapshot.docs
          .where((doc) => doc.id != user?.email) // Assuming email is used as a unique identifier
          .map((doc) => doc.data())
          .toList();

      return allUsersData;
    } catch (e) {
      print('Error retrieving data from Firestore: $e');
      return [];
    }
  }
  Future <void> addToFav(Map<String,dynamic> profileData)async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(user?.email).collection("profileData").add(profileData);
      print("Data added to Firestore successfully! ");
    }catch(e){
      print('Error adding data to Firestore: $e');
    }
  }
  Future<List<Map<String, dynamic>>> getFav() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.email)
          .collection("profileData")
          .get();

      List<Map<String, dynamic>> dataList = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
          dataList.add(data);
        }

        return dataList;
      } else {
        print('No documents found in the collection');
        return [];
      }
    } catch (e) {
      print('Error retrieving data from Firestore: $e');
      return [];
    }
  }
  void deleteFav(Map<String, dynamic> temp){
    try {
      String documentId = temp['documentId']; // Change this to your actual key
      FirebaseFirestore.instance
          .collection("users")
          .doc(user?.email)
          .collection("profileData").doc()
          .delete();
      print("Data removed from Firestore successfully! ");
    } catch (e) {
      print('Error removing data from Firestore: $e');
    }
  }

   void signout(){
     FirebaseAuth.instance.signOut();
  }
  Future<List<String>> getUsersWithMessages(String currentUserUid) async {
    List<String> usersWithMessages = [];

    // Query messages where the current user is either the sender or receiver
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat_rooms').doc().collection("messages")
        .where('senderid', isEqualTo: currentUserUid)
        .get();

    // Add receiver IDs to the list
    querySnapshot.docs.forEach((doc) {
      String receiverId = doc['receiverid'];
      if (!usersWithMessages.contains(receiverId)) {
        usersWithMessages.add(receiverId);
      }
    });

    // Query messages where the current user is the receiver
    querySnapshot = await FirebaseFirestore.instance.collection("chat_rooms").doc()
        .collection('messages')
        .where('receiverid', isEqualTo: currentUserUid)
        .get();

    // Add sender IDs to the list
    querySnapshot.docs.forEach((doc) {
      String senderId = doc['senderid'];
      if (!usersWithMessages.contains(senderId)) {
        usersWithMessages.add(senderId);
      }
    });

    return usersWithMessages;
  }



}