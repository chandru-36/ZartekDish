import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartekdish/commons/commonServices.dart';
import 'package:zartekdish/views/authentications/authenticate.dart';
import 'package:zartekdish/views/authentications/otp.dart';
import 'package:zartekdish/views/home/home.dart';

class AuthService extends GetxService {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signinwithgoogle()async {
     final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {

      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

    final data =    await _auth.signInWithCredential(credential);
    print(data);
    await  SESSION.setStringValue("user",data.user!.displayName! ?? "");
    await  SESSION.setStringValue("uid",data.user!.uid! ?? "");
        Get.offAll(Home());
      }

    }catch(e) {
      Get.snackbar("Error", "some error occured $e");
    }
    
  }
  Future<void> verifyPhone(String phone) async {
    try {
     await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: phone,
                        verificationCompleted: (phoneAuthCredential) {},
                        verificationFailed: (error) {
                          print(error);
                          Get.snackbar("Error", error.message ?? "");
                           return null;
                        },
                        codeSent: (verificationId, forceResendingToken) {
                          print(forceResendingToken);
                          print(verificationId);
                          Get.to(Otp(
                                        verificationId: verificationId,phone:phone
                                      ));
                        },
                        codeAutoRetrievalTimeout: (verificationId) {
                          print("Auto Retireval timeout");
                        },
                      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> verifyOtp(String verificationId,String Otp,String phone) async {
     try {
                      final cred = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: Otp);
                  final data =  await FirebaseAuth.instance.signInWithCredential(cred);
print(data);
await  SESSION.setStringValue("user",data.user!.phoneNumber! ?? "");
    await  SESSION.setStringValue("uid",data.user!.uid! ?? "");
   
                 await  SESSION.setStringValue("user",phone);
                      Get.offAll(Home());
                    } catch (e) {
                      Get.snackbar("Error", "some error occured $e");
                    }
  }

 

}
