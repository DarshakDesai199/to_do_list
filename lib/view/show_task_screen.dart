import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/common/app_const.dart';
import 'package:to_do_list/common/button.dart';
import 'package:to_do_list/common/color.dart';
import 'package:to_do_list/common/image_path.dart';
import 'package:to_do_list/common/text.dart';
import 'package:to_do_list/common/text_field.dart';
import 'package:to_do_list/controller/todo_controller.dart';
import 'package:to_do_list/service/boxes/boxes.dart';
import 'package:to_do_list/service/model/task_add.dart';
import 'package:to_do_list/view/home_screen.dart';

class ShowTaskScreen extends StatefulWidget {
  final int? index, selectImageIndex;

  const ShowTaskScreen({Key? key, this.index, this.selectImageIndex})
      : super(key: key);

  @override
  State<ShowTaskScreen> createState() => _ShowTaskScreenState();
}

class _ShowTaskScreenState extends State<ShowTaskScreen> {
  var deadLineTime;

  TodoController todoController = Get.find();
  @override
  void initState() {
    todoController.selectImage = widget.selectImageIndex!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;
    return Scaffold(
      body: GetBuilder<TodoController>(
        builder: (controller) {
          print('---------${controller.selectImage}');
          return controller.selectImage == -1
              ? buildTaskInfo(size, font)
              : Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        controller.images[controller.selectImage],
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  child: Container(
                    color: Colors.white30,
                    child: buildTaskInfo(
                      size,
                      font,
                    ),
                  ),
                );
        },
      ),
    );
  }

  buildTaskInfo(double size, double font) {
    return ValueListenableBuilder<Box<TaskAdd>>(
      valueListenable: Boxes.addTask().listenable(),
      builder: (context, value, child) {
        final tasks = value.values.toList().cast<TaskAdd>();
        if (tasks[widget.index!].deadline != null) {
          final DateTime? date = tasks[widget.index!].deadline;
          deadLineTime = DateFormat.yMMMMd().format(date!);
        }
        final DateTime? date = tasks[widget.index!].time;
        String addTime = DateFormat.yMMMMd().format(date!);

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24 * size),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 43 * size,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            AppImage.arrowBack,
                            height: 24 * size,
                            width: 24 * size,
                          ),
                        ),
                        Spacer(),
                        Tooltip(
                          padding: EdgeInsets.all(20),
                          triggerMode: TooltipTriggerMode.tap,
                          preferBelow: true,
                          message: tasks[widget.index!].deadline == null
                              ? 'No Deadline'
                              : '$deadLineTime',
                          decoration: BoxDecoration(
                            color: AppColor.secondColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              AppImage.clock,
                              height: 24 * size,
                              width: 24 * size,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            giveValue(tasks);
                            editBottomSheet(context, size, font, tasks);
                          },
                          icon: SvgPicture.asset(
                            AppImage.edit,
                            height: 24 * size,
                            width: 24 * size,
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            deleteBottomSheet(context, size, font, tasks);
                          },
                          icon: SvgPicture.asset(
                            AppImage.trash,
                            height: 24 * size,
                            width: 24 * size,
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            giveValue(tasks);
                            showImageBottomSheet(context, size, font, tasks);
                          },
                          icon: Icon(
                            Icons.color_lens_outlined,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24 * size,
                    ),
                    CommonText(
                      text: tasks[widget.index!].title!,
                      fontWeight: FontWeight.w900,
                      fontSize: 26 * font,
                      maxLine: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 24 * size,
                    ),
                    SizedBox(
                      height: size * 606,
                      width: Get.width,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: CommonText(
                          text: tasks[widget.index!].description!,
                          fontSize: 16 * font,
                          maxLine: 1000,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20 * size,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5 * size),
                  child: CommonText(
                    text: 'Created at ${addTime}',
                    fontSize: 14 * font,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void giveValue(List<TaskAdd> tasks) {
    if (tasks[widget.index!].deadline != null) {
      todoController.updateControllers(
          title: tasks[widget.index!].title,
          des: tasks[widget.index!].description!,
          selectImageIndex:
              tasks[widget.index!].index == widget.selectImageIndex
                  ? tasks[widget.index!].index!
                  : widget.selectImageIndex!,
          deadLines: tasks[widget.index!].deadline);
    } else {
      todoController.updateControllers(
          title: tasks[widget.index!].title,
          des: tasks[widget.index!].description!,
          selectImageIndex:
              tasks[widget.index!].index == widget.selectImageIndex
                  ? tasks[widget.index!].index!
                  : widget.selectImageIndex!,
          deadLines: null);
    }
  }

  updateTask(TodoController controller, List<TaskAdd> tasks) {
    final taskAdd = TaskAdd();
    taskAdd.deadline = controller.deadLine;
    taskAdd.time = DateTime.now();
    taskAdd.description = controller.descriptionController.text;

    taskAdd.title = controller.titleController.text;
    taskAdd.index = controller.selectImage;
    taskAdd.isDeadline = controller.deadLine == null ? false : true;
    print('-----DEAD KINE----${taskAdd.isDeadline}');
    final box = Boxes.addTask();
    box.put(tasks[widget.index!].key, taskAdd);
  }

  Future<dynamic> deleteBottomSheet(
      BuildContext context, double size, double font, List<TaskAdd> tasks) {
    return showModalBottomSheet(
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return SizedBox(
              height: 150 * size,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24 * size),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48 * size,
                      width: Get.width,
                      child: CommonButton(
                        radius: 12,
                        onPressed: () async {
                          final box = Boxes.addTask();
                          box
                              .delete(tasks[widget.index!].key)
                              .then((value) => Get.offAll(() => HomeScreen()));
                        },
                        buttonColor: AppColor.white,
                        child: CommonText(
                          text: 'Delete TODO',
                          fontSize: 14 * font,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16 * size,
                    ),
                    SizedBox(
                      height: 48 * size,
                      width: Get.width,
                      child: CommonButton(
                        radius: 12,
                        onPressed: () {
                          Get.back();
                        },
                        buttonColor: AppColor.white,
                        child: CommonText(
                          text: 'Cancel',
                          fontSize: 14 * font,
                          color: AppColor.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void editBottomSheet(
      BuildContext context, double size, double font, List<TaskAdd> tasks) {
    showModalBottomSheet(
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      barrierColor: AppColor.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return GetBuilder<TodoController>(
              builder: (controller) {
                return Container(
                  height: size * 722,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      left: size * 24, right: size * 24, top: size * 16),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppImage.rectangle,
                        height: size * 6,
                        width: size * 80,
                      ),
                      SizedBox(
                        height: size * 20,
                      ),
                      CommonTextField(
                        controller: controller.titleController,
                        borderRadius: 12,
                        enabledBorderColor: AppColor.white,
                        focusedBorderColor: AppColor.white,
                        cursorColor: AppColor.white,
                        hintText: 'Title',
                        hintTextColor: AppColor.white,
                        textFieldSize: size * 14,
                        inputTextSize: font * 16,
                        inputTextColor: AppColor.white,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: size * 10,
                      ),
                      CommonTextField(
                        controller: controller.descriptionController,
                        borderRadius: 12,
                        maxLines: 20,
                        enabledBorderColor: AppColor.white,
                        focusedBorderColor: AppColor.white,
                        cursorColor: AppColor.white,
                        hintText: 'Description',
                        hintTextColor: AppColor.white,
                        textFieldSize: size * 14,
                        inputTextSize: font * 16,
                        inputTextColor: AppColor.white,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: size * 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColor
                                          .mainColor, // header background color
                                      onPrimary:
                                          AppColor.white, // header text color
                                      onSurface:
                                          AppColor.white, // body text color
                                    ),
                                    dialogBackgroundColor: AppColor.black,
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                          textStyle: TextStyle(
                                              color: AppColor.white,
                                              fontWeight: FontWeight
                                                  .w600) // ton text color
                                          ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            controller.updateDeadLine(pickedDate);
                          }
                        },
                        child: Container(
                          height: size * 48,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.white,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 16 * size, right: 12 * size),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.deadLine == null
                                  ? CommonText(
                                      text: 'Deadline (Optional)',
                                      fontSize: font * 16,
                                      color: AppColor.white,
                                    )
                                  : CommonText(
                                      text: controller.deadLine
                                          .toString()
                                          .split(' ')
                                          .first,
                                      fontSize: font * 16,
                                      color: AppColor.white,
                                    ),
                              SvgPicture.asset(
                                AppImage.calendar,
                                height: size * 24,
                                width: size * 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size * 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          height: size * 48,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColor.white,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 16 * size, right: 12 * size),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CommonText(
                                  text: controller.fileName == '' ||
                                          controller.fileName.isEmpty
                                      ? 'Add Image (Optional)'
                                      : controller.fileName,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: font * 16,
                                  color: AppColor.white,
                                ),
                              ),
                              SvgPicture.asset(
                                AppImage.image,
                                height: size * 24,
                                width: size * 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size * 16,
                      ),
                      SizedBox(
                        height: size * 48,
                        width: Get.width,
                        child: CommonButton(
                          onPressed: () async {
                            updateTask(controller, tasks);

                            Get.back();
                            controller.clearAllValue();
                          },
                          buttonColor: AppColor.white,
                          radius: 12,
                          child: CommonText(
                            text: 'EDIT TODO',
                            fontSize: font * 14,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    ).whenComplete(() => todoController.clearAllValue());
  }

  void showImageBottomSheet(
    BuildContext context,
    double size,
    double font,
    List<TaskAdd> tasks,
  ) {
    showModalBottomSheet(
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      barrierColor: AppColor.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return GetBuilder<TodoController>(
              builder: (controller) {
                return Container(
                  height: size * 100,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(12),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          7,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.updateSelectImageIndex(index);
                                updateTask(controller, tasks);
                                setStat(() {});
                              },
                              child: Container(
                                height: size * 50,
                                width: size * 50,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.only(
                                    left: size * 12, right: size * 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        controller.images[index],
                                      ),
                                      fit: BoxFit.cover),
                                  border: Border.all(
                                    color: controller.selectImage == index
                                        ? AppColor.white
                                        : AppColor.transparent,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

///UPDATE
// await FirebaseFirestore.instance
//     .collection('User')
//     .doc(kFirebaseAuth.currentUser!.uid)
//     .collection('Task')
//     .doc(widget.taskId)
//     .update({
//   'title': controller.titleController.text,
//   'description':
//       controller.descriptionController.text,
//   'deadline': controller.deadLine,
//   'isDeadline':
//       controller.deadLine == null ? false : true,
//   'time': DateTime.now()
// });

/// DELETE
// await FirebaseFirestore.instance
//     .collection('User')
//     .doc(kFirebaseAuth.currentUser!.uid)
//     .collection('Task')
//     .doc(widget.taskId)
//     .delete();
/// STREAM BUILDER
// StreamBuilder(
//   stream: FirebaseFirestore.instance
//       .collection('User')
//       .doc(kFirebaseAuth.currentUser!.uid)
//       .collection('Task')
//       .doc(widget.taskId)
//       .snapshots(),
//   builder: (BuildContext context,
//       AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//     if (snapshot.hasData) {
//       DateTime? date;
//       var addingTime;
//       var data = snapshot.data;
//       if (data!['deadline'] != null) {
//         var timestamp = data['deadline'].seconds; // timestamp in seconds
//         date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//         addingTime = DateFormat.yMMMMd().format(date);
//
//         todoController.updateControllers(
//             title: data['title'],
//             des: data['description'],
//             deadLines: date);
//       }
//       return Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24 * size),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 43 * size,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     borderRadius: BorderRadius.circular(100),
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: SvgPicture.asset(
//                       AppImage.arrowBack,
//                       height: 24 * size,
//                       width: 24 * size,
//                     ),
//                   ),
//                   Spacer(),
//                   Tooltip(
//                     padding: EdgeInsets.all(20),
//                     triggerMode: TooltipTriggerMode.tap,
//                     preferBelow: true,
//                     message: data['deadline'] == null
//                         ? 'No Deadline'
//                         : '$addingTime',
//                     decoration: BoxDecoration(
//                       color: AppColor.secondColor,
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SvgPicture.asset(
//                         AppImage.clock,
//                         height: 24 * size,
//                         width: 24 * size,
//                         color: AppColor.black,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     splashRadius: 20,
//                     onPressed: () {
//                       if (data['deadline'] != null) {
//                         var timestamp = data['deadline']
//                             .seconds; // timestamp in seconds
//                         final DateTime date =
//                             DateTime.fromMillisecondsSinceEpoch(
//                                 timestamp * 1000);
//                         todoController.updateControllers(
//                             title: data['title'],
//                             des: data['description'],
//                             deadLines: date);
//                       } else {
//                         todoController.updateControllers(
//                             title: data['title'],
//                             des: data['description'],
//                             deadLines: null);
//                       }
//                       editBottomSheet(context, size, font);
//                     },
//                     icon: SvgPicture.asset(
//                       AppImage.edit,
//                       height: 24 * size,
//                       width: 24 * size,
//                     ),
//                   ),
//                   IconButton(
//                     splashRadius: 20,
//                     onPressed: () {
//                       deleteBottomSheet(context, size, font);
//                     },
//                     icon: SvgPicture.asset(
//                       AppImage.trash,
//                       height: 24 * size,
//                       width: 24 * size,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 24 * size,
//               ),
//               CommonText(
//                 text: data!['title'],
//                 fontWeight: FontWeight.w900,
//                 fontSize: 26 * font,
//                 maxLine: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               SizedBox(
//                 height: 24 * size,
//               ),
//               SizedBox(
//                 height: size * 606,
//                 width: Get.width,
//                 child: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: CommonText(
//                     text: data['description'],
//                     fontSize: 16 * font,
//                     maxLine: 1000,
//                     height: 1.5,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else if (snapshot.hasError) {
//       return Center(
//         child: Text('Server Error'),
//       );
//     } else {
//       return Center(
//         child: SizedBox(
//           width: 100,
//           height: 100,
//           child: Lottie.asset(AppImage.loader),
//         ),
//       );
//     }
//   },
// ),

/// FOR TIME
// StreamBuilder(
//   stream: FirebaseFirestore.instance
//       .collection('User')
//       .doc(kFirebaseAuth.currentUser!.uid)
//       .collection('Task')
//       .doc(widget.taskId)
//       .snapshots(),
//   builder: (BuildContext context,
//       AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//     if (snapshot.hasData) {
//       var data = snapshot.data;
//
//       var timestamp = data!['time'].seconds; // timestamp in seconds
//       final DateTime date =
//           DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//       var addingTime = DateFormat.yMMMMd().format(date);
//       return Center(
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 5 * size),
//           child: CommonText(
//             text: 'Created at $addingTime',
//             fontSize: 14 * font,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       );
//     } else if (snapshot.hasError) {
//       return Center(
//         child: Text('Server Error'),
//       );
//     } else {
//       return Center(
//         child: SizedBox(
//           width: 100,
//           height: 100,
//         ),
//       );
//     }
//   },
// ),
