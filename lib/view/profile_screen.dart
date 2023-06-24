// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:to_do_list/common/app_const.dart';
// import 'package:to_do_list/common/color.dart';
// import 'package:to_do_list/common/image_path.dart';
// import 'package:to_do_list/common/text.dart';
// import 'package:to_do_list/controller/auth_controller.dart';
// import 'package:to_do_list/controller/profile_controller.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   AuthController authController = Get.find();
//   ProfileController profileController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size.height / defaultHeight;
//     double font = size * 0.97;
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24 * size),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: size * 50),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: SvgPicture.asset(AppImage.arrowBack,
//                         height: size * 24, width: size * 24),
//                   ),
//                   SizedBox(
//                     width: 15 * size,
//                   ),
//                   SvgPicture.asset(
//                     AppImage.toDoList,
//                     height: size * 18,
//                     width: size * 83,
//                   ),
//                 ],
//               ),
//               SizedBox(height: size * 150),
//               Image.asset(
//                 AppImage.profile,
//                 height: 243 * size,
//                 width: Get.width,
//               ),
//               GetBuilder<ProfileController>(
//                 builder: (controller) {
//                   return Column(
//                     children: [
//                       SizedBox(height: size * 109),
//                       tiles(
//                         font: font,
//                         title: 'Full Name',
//                         value: '${controller.name}',
//                       ),
//                       SizedBox(height: size * 16),
//                       tiles(
//                         font: font,
//                         title: 'Email',
//                         value: '${controller.email}',
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               SizedBox(height: size * 40),
//               // SizedBox(
//               //   height: 48 * size,
//               //   width: Get.width,
//               //   child: CommonButton(
//               //     radius: 12,
//               //     buttonColor: AppColor.mainColor,
//               //     onPressed: () async {
//               //       Loader.showProgressDialog(context);
//               //       try {
//               //         bool status = await authController.logOutUser();
//               //
//               //         if (status == true) {
//               //           // Get.offAll(() => LogInScreen());
//               //           GetStorageService.getClear();
//               //           Loader.hideProgressDialog();
//               //           CommonSnackBar.getSuccessSnackBar(
//               //               context: context, title: 'Log out Successfully');
//               //         } else {
//               //           Loader.hideProgressDialog();
//               //           CommonSnackBar.getFailedSnackBar(
//               //               context: context, title: 'Log out Failed');
//               //         }
//               //       } catch (e) {
//               //         print('------$e');
//               //         Loader.hideProgressDialog();
//               //         CommonSnackBar.getFailedSnackBar(
//               //             context: context, title: 'Log out Failed');
//               //       }
//               //     },
//               //     child: CommonText(text: 'LOG OUT', color: AppColor.white),
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row tiles({double? font, String? title, String? value}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CommonText(
//           text: title!,
//           fontSize: 16 * font!,
//           color: AppColor.greyShade400,
//         ),
//         CommonText(
//           text: value!,
//           fontSize: 16 * font,
//           color: AppColor.mainColor,
//         ),
//       ],
//     );
//   }
// }
