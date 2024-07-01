import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/firebase_options.dart';
import 'package:zartekdish/views/authentications/authenticate.dart';
import 'package:zartekdish/views/cart/orderSummary.dart';
import 'package:zartekdish/views/home/home.dart';
import 'package:zartekdish/views/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
       appBarTheme: AppBarTheme(
          color: Colors.white, // AppBar background color
          
        ),
      ),
      home: const Landing(),
    );
  }
}
