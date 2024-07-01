import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zartekdish/views/authentications/authenticate.dart';
import 'package:zartekdish/views/home/home.dart';
import 'package:zartekdish/views/landing.dart';

class OrderSuccessDialog extends StatelessWidget {
  final String message;

  const OrderSuccessDialog({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lotties/order_confirmed.json'),
          const SizedBox(
              height: 16), 
          Text(message),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Landing()),
              (Route<dynamic> route) => false, // Remove all previous routes
            );
          },
          child: const Text('OK'),
          
        ),
      ],
    );
  }
}
