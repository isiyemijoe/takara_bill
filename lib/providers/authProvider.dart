import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:takara_bill/AppEngine.dart';
import 'package:takara_bill/StringAssets.dart';
import 'package:takara_bill/models/SignupDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //On every Login, i want save and fetch the user name and email
    prefs.setBool(FIRST_TIME, false);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = FirebaseAuth.instance.currentUser;
      if(user.emailVerified){
        _db
            .collection("Debtors")
            .doc(user.email).get().then((value){
          Map<String , dynamic> doc = value.data();
          String name = doc['name'];
          String number = doc['number'];
          String fName = getName(name);
          prefs.setString(NAME, fName);
          prefs.setString(FULLNAME, name);
          prefs.setString(EMAIL, user.email);
          prefs.setString(NUMBER, number);

        });

        return SIGN_IN;
      }
      else{
        FirebaseAuth.instance.signOut();
        return "Please verify your mail";
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if(e.message.contains("record")){
        return"No user with this email";
      }
      if(e.message.contains("password")){
        return"Invalid password, try again";
      }
      if(e.message.contains("network")){
        return"Network error, Check your internet connection and try again";
      }
      return e.message;
    }
    //notifyListeners();
  }

  Future<String> signUp(SignupDetails details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(FIRST_TIME, false);
    String fName = getName(details.name);
    prefs.setString(NAME, fName);
    prefs.setString(EMAIL, details.email);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: details.email, password: details.password);
      User user = FirebaseAuth.instance.currentUser;
      _db.collection("Debtors")
          .doc(user.email).set(
          {
            'name': details.name,
              'number': details.phone
          }
      );
      try{}
      catch(e){
        print("error sending verification");
      }
      user.sendEmailVerification();
      FirebaseAuth.instance.signOut();
      return SIGN_UP;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if(e.message.contains("exist")){
        return"No user with this email";
      }
      if(e.message.contains("network")){
        return"Network error, Check your internet connection and try again";
      }
      return e.message;
    }
  }
  Future<String> resetPassword(String email) async{
    try{
      await  FirebaseAuth.instance.sendPasswordResetEmail(email:email);
      return SUCCESSFUL;
    } on FirebaseAuthException catch (e){
      return FAILED;
    }

  }

}
