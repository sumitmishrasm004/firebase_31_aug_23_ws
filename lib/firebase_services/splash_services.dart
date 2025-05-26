import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/ui/auth/post/post_screen.dart';
import 'package:flutter_application_1/ui/firestore/firestore_list_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if (user != null) {
      // Timer(
      //     const Duration(seconds: 3),
      //     () => Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => PostScreen())));
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => FireStoreScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
