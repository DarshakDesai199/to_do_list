import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:to_do_list/common/app_const.dart';
import 'package:to_do_list/common/image_path.dart';
import 'package:to_do_list/service/get_storage_service.dart';
import 'package:to_do_list/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getFcmToken();

    Timer(Duration(seconds: 2), () {
      Get.offAll(
          () =>
              // GetStorageService.getLogin() == true
              //     ?
              HomeScreen(), // : LogInScreen(),
          transition: Transition.zoom);
    });
    super.initState();
  }

  getFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();

      GetStorageService.setFcmToken(value: token);
    } catch (e) {
      print('----ERROR---');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImage.todo,
              height: 180 * size,
              width: 187 * size,
            ),
          ],
        ),
      ),
    );
  }
}
