import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/controllers/authController.dart';
import 'package:zartekdish/views/authentications/phoneLogin.dart';
import 'package:zartekdish/views/home/home.dart';

class Authenticate extends StatelessWidget {
  Authenticate({Key? key}) : super(key: key);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final authController = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/images/firebase.png",
                )),
            const SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: () async {
                await authController.signinwithgoogle();
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: 55,
                width: Get.width,
                decoration: BoxDecoration(
                    color: CusColors.googlebtn,
                    borderRadius: BorderRadius.circular(35)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "assets/images/google2.png",
                          )),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Google",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(const PhoneLogin());
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: 55,
                width: Get.width,
                
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                  colors: [ CusColors.greenlight,CusColors.greendark,],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                    borderRadius: BorderRadius.circular(35)),
                child: const Stack(
                  children: [
                    Positioned(
                        left: 20,
                        top: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 30,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Phone",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
