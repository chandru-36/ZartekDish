import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:zartekdish/controllers/authController.dart';
import 'package:zartekdish/views/widgets/customButton.dart';

class Otp extends StatefulWidget {
  const Otp({super.key, required this.verificationId, required this.phone});
  final String verificationId;
  final String phone;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final service = Get.put(AuthService());
  OtpFieldController otpController = OtpFieldController();
  String otpVal = '';

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/firebase.png",
              )),
          const Text(
            "Verify the OTP here",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 40),
          OTPTextField(
              controller: otpController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 45,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {
                setState(() {
                  otpVal = pin;
                });
              },
              onCompleted: (pin) {
                setState(() {
                  otpVal = pin;
                });
              }),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator()
              : CustomButton(
                  text: 'Verify',
                  onPressed: () async {
                    if (otpVal.isNotEmpty && otpVal.length == 6) {
                      setState(() {
                        isLoading = true;
                      });
                      await service.verifyOtp(
                          widget.verificationId, otpVal, widget.phone);

                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      Get.snackbar("Error", "Enter valid OTP");
                    }
                  },
                  width: 200,
                  height: 50,
                )
        ],
      ),
    ));
  }
}
