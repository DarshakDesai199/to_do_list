import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/controller_binding.dart';
import 'package:to_do_list/new_picker.dart';
import 'package:to_do_list/service/model/task_add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAddAdapter());
  await Hive.openBox<TaskAdd>('taskAdd');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      initialBinding: ControllerBindings(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // home: SplashScreen(),
      home: DateTimePickerBottomSheet(),
    );
  }
}
