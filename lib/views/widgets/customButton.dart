import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/commons/commonServices.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color color;

  CustomButton({
    required this.text,
    required this.onPressed,
    required this.width,
    this.height=40,
    this.color = const Color(0xFF54b753),

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          onPressed();
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(35)),
          child:  Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
      );
  }
}