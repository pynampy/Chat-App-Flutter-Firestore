import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../widgets/auth-form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm (
    String email,
    String password,
    String userName,
    File userImage,
    bool isLogin,  
    BuildContext ctx,
     )  async {
       AuthResult authResult;

        
      try{
        setState(() {
          _isLoading = true;
        });
         if(isLogin){

         authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
       } else {

         authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);

         final ref = FirebaseStorage.instance.ref().child('user_image').child(authResult.user.uid +'.jpg');

         await ref.putFile(userImage).onComplete;

          final url =  await ref.getDownloadURL();

        await Firestore.instance.collection("users").document(authResult.user.uid).setData({
          'username' : userName,
          'email': email,
          'Image_url' : url

        });

       }
       }on PlatformException catch(error){
          setState(() {
          _isLoading = false;
        });
         var message = "An error Occurred!, Please Check your credentials ! ";

         if(error.message != null){
           message = error.message;
         }

         Scaffold.of(ctx)
         .showSnackBar(SnackBar(content: Text(message),backgroundColor: Theme.of(ctx).errorColor,));
       } catch(err){
          setState(() {
          _isLoading = false;
        });
         print(err);
       }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm,_isLoading),
      
    );
  }
}