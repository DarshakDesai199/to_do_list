// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:to_do_list/controller/auth_controller.dart';
//
// class ProfileController extends GetxController {
//   String? name, email;
//
//   getCurrentUserDetail() async {
//     var data = await FirebaseFirestore.instance
//         .collection('User')
//         .doc(kFirebaseAuth.currentUser!.uid)
//         .get();
//
//     Map<String, dynamic>? userData = data.data();
//
//     name = userData!['fullName'];
//     email = userData['email'];
//   }
// }
