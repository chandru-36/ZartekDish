import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusColors {
  CusColors._();
  static Color googlebtn = const Color(0xFF4286f6);
  static Color greendark = const Color(0xFF54b753);
  static Color greenlight = const Color(0xFF7bd756);
  static Color greendeepdark = const Color(0xFF1b3f13);
  
  
}

class GO {
  GO._();
  static Future<void> next(Widget widget) async {
    await Navigator.push(
        Get.context!,
        PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeftWithFade,
            child: widget));
  }

  static back() {
    Navigator.pop(Get.context!);
  }
}

class SESSION{
  SESSION._();

  static setStringValue(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

static Future<String> getStringvalue(key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString(key) ?? "";
  return value;
}

 static removeAll() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
}

Widget loader({double width = 200}) {
  return Center(
    child: CircularProgressIndicator(),
      );
}

Widget error({double width = 200}) {
  return Center(
    child: Text(
      "Something Wrong",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20
      ),
    ),
      );
}

Widget nodata({double width = 200}) {
  return Center(
    child: Text(
      "No Items found",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20
      ),
    ),
      );
}


