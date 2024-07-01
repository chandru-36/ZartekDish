import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zartekdish/controllers/authController.dart';
import 'package:zartekdish/views/widgets/customButton.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final authService = Get.put(AuthService());
  TextEditingController phone = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              "Phone Number Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phone,
              decoration: InputDecoration(
                  hintText: "Enter Phone",
                  prefixIcon: Container(
                      alignment: Alignment.center,
                      width: 50,
                      child: const Text(
                        "+91 | ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black))),
            ),
            const SizedBox(height: 20),
            isloading
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: 'Sign In',
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      await authService.verifyPhone("+91" + phone.text);
                      setState(() {
                        isloading = false;
                      });
                    },
                    width: 200,
                    height: 50,
                  )
          ],
        ),
      ),
    );
  }
}
