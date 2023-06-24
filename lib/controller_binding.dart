import 'package:get/get.dart';
import 'package:to_do_list/controller/todo_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthController>(
    //   () => AuthController(),
    //   fenix: true,
    // );
    Get.lazyPut<TodoController>(
      () => TodoController(),
      fenix: true,
    );
    // Get.lazyPut<ProfileController>(
    //   () => ProfileController(),
    //   fenix: true,
    // );
  }
}
