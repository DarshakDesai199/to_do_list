// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:to_do_list/common/app_const.dart';
// import 'package:to_do_list/common/button.dart';
// import 'package:to_do_list/common/color.dart';
// import 'package:to_do_list/common/image_path.dart';
// import 'package:to_do_list/common/text.dart';
// import 'package:to_do_list/common/text_field.dart';
// import 'package:to_do_list/controller/auth_controller.dart';
//
// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);
//
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
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 180 * size,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: SvgPicture.asset(
//                         AppImage.todo,
//                         height: 180 * size,
//                         width: 187 * size,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 192 * size,
//                     ),
//
//                     CommonTextField(
//                       controller: controller.emailController,
//                       borderRadius: 12,
//                       enabledBorderColor: AppColor.greyShade400,
//                       focusedBorderColor: AppColor.mainColor,
//                       cursorColor: AppColor.mainColor,
//                       hintText: 'Enter Email',
//                       hintTextColor: AppColor.greyShade400,
//                       textFieldSize: size * 14,
//                       inputTextSize: font * 16,
//                       inputTextColor: AppColor.mainColor,
//                       textInputAction: TextInputAction.done,
//                     ),
//                     SizedBox(
//                       height: 5 * size,
//                     ),
//                     CommonText(
//                       text:
//                           '* The reset password link send in this following email.',
//                       fontSize: font * 12,
//                       color: AppColor.greyShade400,
//                     ),
//                     // CommonTextField(
//                     //   controller: controller.confirmPasswordController,
//                     //   borderRadius: 12,
//                     //   enabledBorderColor: AppColor.greyShade400,
//                     //   focusedBorderColor: AppColor.mainColor,
//                     //   cursorColor: AppColor.mainColor,
//                     //   hintText: 'Confirm Password',
//                     //   hintTextColor: AppColor.greyShade400,
//                     //   textFieldSize: size * 14,
//                     //   inputTextSize: font * 16,
//                     //   obscureText: controller.showPass,
//                     //   inputTextColor: AppColor.mainColor,
//                     //   textInputAction: TextInputAction.done,
//                     //   suffixIcon: IconButton(
//                     //     splashRadius: 20,
//                     //     icon: Icon(
//                     //       controller.showPass
//                     //           ? Icons.visibility_outlined
//                     //           : Icons.visibility_off_outlined,
//                     //       size: size * 24,
//                     //     ),
//                     //     onPressed: () {
//                     //       controller.updateShowPassword();
//                     //     },
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: 15 * size,
//                     ),
//                     SizedBox(
//                       height: 24 * size,
//                     ),
//                     SizedBox(
//                       height: size * 48,
//                       width: Get.width,
//                       child: CommonButton(
//                         onPressed: () {
//                           controller.resetPasswordLink(
//                               email: controller.emailController.text.trim(),
//                               context: context);
//                         },
//                         buttonColor: AppColor.mainColor,
//                         radius: 12,
//                         child: CommonText(
//                           text: 'CHANGE PASSWORD',
//                           fontSize: font * 14,
//                           color: AppColor.white,
//                         ),
//                       ),
//                     ),
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
