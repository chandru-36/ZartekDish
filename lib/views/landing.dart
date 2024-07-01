import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/views/authentications/authenticate.dart';
import 'package:zartekdish/views/home/home.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    Load_page();
    super.initState();
  }

  Load_page() async {
    String? data = await SESSION.getStringvalue("user");
    Future.delayed(const Duration(seconds: 2), () {
      if (data == null || data.isEmpty) {
        Get.offAll(Authenticate());
      } else {
        Get.offAll(const Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              "assets/images/firebase.png",
            )),
      ),
    );
  }
}
