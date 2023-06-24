// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:to_do_list/common/app_const.dart';
// import 'package:to_do_list/common/button.dart';
// import 'package:to_do_list/common/color.dart';
// import 'package:to_do_list/common/common_snackbar.dart';
// import 'package:to_do_list/common/image_path.dart';
// import 'package:to_do_list/common/loader.dart';
// import 'package:to_do_list/common/text.dart';
// import 'package:to_do_list/common/text_field.dart';
// import 'package:to_do_list/controller/auth_controller.dart';
// import 'package:to_do_list/service/get_storage_service.dart';
// import 'package:to_do_list/view/auth/forgot_password_screen.dart';
// import 'package:to_do_list/view/auth/sign_up_screen.dart';
// import 'package:to_do_list/view/home_screen.dart';
//
// class LogInScreen extends StatefulWidget {
//   const LogInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LogInScreen> createState() => _LogInScreenState();
// }
//
// class _LogInScreenState extends State<LogInScreen> {
//   AuthController logInController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size.height / defaultHeight;
//     double font = size * 0.97;
//     return Scaffold(
//       body: Center(
//         child: GetBuilder<AuthController>(
//           builder: (controller) {
//             return SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: size * 24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 180 * size,
//                     ),
//                     SvgPicture.asset(
//                       AppImage.todo,
//                       height: 180 * size,
//                       width: 187 * size,
//                     ),
//                     SizedBox(
//                       height: 170 * size,
//                     ),
//                     CommonTextField(
//                       controller: controller.emailController,
//                       borderRadius: 12,
//                       enabledBorderColor: AppColor.greyShade400,
//                       focusedBorderColor: AppColor.mainColor,
//                       cursorColor: AppColor.mainColor,
//                       hintText: 'Email',
//                       hintTextColor: AppColor.greyShade400,
//                       textFieldSize: size * 14,
//                       inputTextSize: font * 16,
//                       inputTextColor: AppColor.mainColor,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     SizedBox(
//                       height: 16 * size,
//                     ),
//                     CommonTextField(
//                       controller: controller.passwordController,
//                       borderRadius: 12,
//                       enabledBorderColor: AppColor.greyShade400,
//                       focusedBorderColor: AppColor.mainColor,
//                       cursorColor: AppColor.mainColor,
//                       hintText: 'Password',
//                       hintTextColor: AppColor.greyShade400,
//                       textFieldSize: size * 14,
//                       inputTextSize: font * 16,
//                       obscureText: controller.showPass,
//                       inputTextColor: AppColor.mainColor,
//                       textInputAction: TextInputAction.done,
//                       suffixIcon: IconButton(
//                         splashRadius: 20,
//                         icon: Icon(
//                           controller.showPass
//                               ? Icons.visibility_outlined
//                               : Icons.visibility_off_outlined,
//                           size: size * 24,
//                         ),
//                         onPressed: () {
//                           controller.updateShowPassword();
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15 * size,
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: InkWell(
//                         onTap: () {
//                           Get.to(() => ForgotPasswordScreen());
//                         },
//                         child: CommonText(
//                           text: 'Forgot Password?',
//                           fontSize: font * 12,
//                           color: AppColor.greyShade400,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16 * size,
//                     ),
//                     SizedBox(
//                       height: size * 48,
//                       width: Get.width,
//                       child: CommonButton(
//                         onPressed: () async {
//                           Loader.showProgressDialog(context);
//                           try {
//                             String? token =
//                                 await FirebaseMessaging.instance.getToken();
//
//                             GetStorageService.setFcmToken(value: token);
//                           } catch (e) {
//                             print('----ERROR---');
//                           }
//
//                           try {
//                             if (controller.emailController.text.isEmpty) {
//                               Loader.hideProgressDialog();
//
//                               CommonSnackBar.getWarningSnackBar(
//                                   title: 'Enter Email', context: context);
//                             } else if (controller
//                                 .passwordController.text.isEmpty) {
//                               Loader.hideProgressDialog();
//
//                               CommonSnackBar.getWarningSnackBar(
//                                   title: 'Enter Password', context: context);
//                             } else {
//                               bool value = await controller.loginUser(
//                                   email: controller.emailController.text.trim(),
//                                   password:
//                                       controller.passwordController.text.trim(),
//                                   context: context);
//                               if (value == true) {
//                                 CommonSnackBar.getSuccessSnackBar(
//                                     context: context,
//                                     title: 'Log In Successfully');
//                                 Get.offAll(() => HomeScreen(),
//                                     transition: Transition.leftToRight);
//                                 GetStorageService.setLogin(value: true);
//                                 await FirebaseFirestore.instance
//                                     .collection('User')
//                                     .doc(kFirebaseAuth.currentUser!.uid)
//                                     .update({
//                                   'fcm':
//                                       GetStorageService.getFcmToken().toString()
//                                 });
//
//                                 Loader.hideProgressDialog();
//                               } else {
//                                 Loader.hideProgressDialog();
//                               }
//                             }
//                           } catch (e) {
//                             print('-----EROOR LOGIN---$e');
//                             Loader.hideProgressDialog();
//
//                             CommonSnackBar.getFailedSnackBar(
//                                 title: 'LogIn Failed', context: context);
//                           }
//                         },
//                         buttonColor: AppColor.mainColor,
//                         radius: 12,
//                         child: CommonText(
//                           text: 'SIGN IN',
//                           fontSize: font * 14,
//                           color: AppColor.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15 * size,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CommonText(
//                           text: 'Don\'t have an account? ',
//                           fontSize: font * 12,
//                           color: AppColor.greyShade400,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             controller.clearValue();
//
//                             Get.offAll(
//                               () => SignUpScreen(),
//                               transition: Transition.rightToLeft,
//                             );
//                           },
//                           child: CommonText(
//                             text: 'Sign up',
//                             fontSize: font * 12,
//                             color: AppColor.mainColor,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
