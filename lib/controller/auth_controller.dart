// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:to_do_list/common/common_snackbar.dart';
// import 'package:to_do_list/common/loader.dart';
//
// FirebaseAuth kFirebaseAuth = FirebaseAuth.instance;
//
// class AuthController extends GetxController {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController fullNameController = TextEditingController();
//
//   bool showPass = true;
//   updateShowPassword() {
//     showPass = !showPass;
//     update();
//   }
//
//   Future<bool> signUpUser(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       await kFirebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       update();
//
//       return true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'network-request-failed') {
//         print('ERROR CREATE ON SIGN UP TIME == No Internet Connection.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "No Internet Connection.");
//       } else if (e.code == 'too-many-requests') {
//         print(
//             'ERROR CREATE ON SIGN UP TIME == Too many attempts please try later');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "Too many attempts please try later.");
//       } else if (e.code == 'weak-password') {
//         print(
//             'ERROR CREATE ON SIGN UP TIME == The password provided is too weak.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "The password provided is too weak.");
//       } else if (e.code == 'email-already-in-use') {
//         print(
//             'ERROR CREATE ON SIGN UP TIME == The account already exists for that email.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context,
//             title: "The account already exists for that email.");
//       } else if (e.code == 'invalid-email') {
//         print(
//             'ERROR CREATE ON SIGN UP TIME == The email address is not valid.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "The email address is not valid.");
//       } else if (e.code == 'weak-password') {
//         print(
//             'ERROR CREATE ON SIGN UP TIME == The password is not strong enough.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "The password is not strong enough.");
//       } else {
//         print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "Something went to wrong.");
//       }
//       update();
//
//       return false;
//     }
//   }
//
//   Future<bool> loginUser(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     try {
//       await kFirebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       update();
//
//       return true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'network-request-failed') {
//         print('ERROR CREATE ON SIGN IN TIME == No Internet Connection.');
//
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "No Internet Connection.");
//       } else if (e.code == 'too-many-requests') {
//         print(
//             'ERROR CREATE ON SIGN IN TIME == Too many attempts please try later');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "Too many attempts please try later.");
//       } else if (e.code == 'user-not-found') {
//         print('ERROR CREATE ON SIGN IN TIME == No user found for that email.');
//
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "No user found for that email.");
//       } else if (e.code == 'wrong-password') {
//         print(
//             'ERROR CREATE ON SIGN IN TIME == The password is invalid for the given email.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context,
//             title: "The password is invalid for the given email.");
//       } else if (e.code == 'invalid-email') {
//         print(
//             'ERROR CREATE ON SIGN IN TIME == The email address is not valid.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "The email address is not valid.");
//       } else if (e.code == 'user-disabled') {
//         print(
//             'ERROR CREATE ON SIGN IN TIME ==  The user corresponding to the given email has been disabled.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context,
//             title:
//                 "The user corresponding to the given email has been disabled.");
//       } else {
//         print('ERROR CREATE ON SIGN IN TIME ==  Something went to Wrong.');
//         CommonSnackBar.getFailedSnackBar(
//             context: context, title: "Something went to wrong.");
//       }
//       update();
//
//       return false;
//     }
//   }
//
//   Future<bool> logOutUser() async {
//     try {
//       await kFirebaseAuth.signOut();
//       return true;
//     } catch (e) {
//       print('----ERROR---LOGOUT----$e');
//       return false;
//     }
//     update();
//   }
//
//   resetPasswordLink({required String email, BuildContext? context}) async {
//     try {
//       Loader.showProgressDialog(context!);
//       await kFirebaseAuth.sendPasswordResetEmail(email: email).then((val) {
//         CommonSnackBar.getSuccessSnackBar(
//             title: 'Link Sent Successfully', context: context);
//         Loader.hideProgressDialog();
//
//         Get.back();
//         clearValue();
//         update();
//       });
//     } catch (error) {
//       CommonSnackBar.getFailedSnackBar(title: 'Try Again', context: context);
//       Loader.hideProgressDialog();
//
//       update();
//
//       // An error happened.
//     }
//     update();
//   }
//
//   clearValue() {
//     emailController.clear();
//     passwordController.clear();
//     confirmPasswordController.clear();
//     fullNameController.clear();
//     update();
//   }
// }
