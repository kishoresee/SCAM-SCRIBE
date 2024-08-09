import 'package:spamexposeapp/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import Firebase Core
///import 'package:loanapp/firebase_options.dart';
//import 'package:emiapp/loginPage.dart';
import 'package:get/get.dart';
import 'package:spamexposeapp/pages/login.dart';
import 'package:spamexposeapp/pages/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  runApp(GetMaterialApp(
    home: MyHomePage(),
  ));
}
