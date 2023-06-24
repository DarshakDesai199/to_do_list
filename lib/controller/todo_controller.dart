import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:to_do_list/common/image_path.dart';
import 'package:to_do_list/service/get_storage_service.dart';

class TodoController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? deadLine;
  File? image;
  String fileName = '';
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'webp', 'jpeg'],
    );
    if (result != null) {
      image = File(result.files.single.path!);

      fileName = image!.path.toString().split('/').last;
      print('-----RESULT---${image!.path}');
    }
    update();
  }

  updateDeadLine(DateTime value) {
    deadLine = value;
    update();
  }

  clearAllValue() {
    titleController.clear();
    descriptionController.clear();
    deadLine = null;
    image = null;
    fileName = '';
    update();
  }

  updateControllers(
      {String? title = '',
      String des = '',
      DateTime? deadLines,
      int selectImageIndex = -1}) {
    titleController.text = title!;
    descriptionController.text = des;
    deadLine = deadLines;
    selectImage = selectImageIndex;
    update();
  }

  bool isGridView = false;

  updateView() {
    isGridView = !isGridView;

    GetStorageService.setView(value: isGridView);
    update();
  }

  List<String> images = [
    AppImage.image1,
    AppImage.image2,
    AppImage.image3,
    AppImage.image4,
    AppImage.image5,
    AppImage.image6,
    AppImage.image7,
  ];
  int selectImage = -1;

  updateSelectImageIndex(int index) {
    selectImage = index;
    update();
  }
}
