import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import 'package:to_do_list/view/show_task_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController todoController = Get.find();

  int selectFilter = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / defaultHeight;
    double font = size * 0.97;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColor.secondColor,
        onPressed: () {
          showAddTaskBottomSheet(font: font, size: size, context: context);
        },
        child: SvgPicture.asset(
          AppImage.addIcon,
          height: size * 24,
          width: size * 24,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size * 60),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppImage.toDoList,
                    height: size * 18,
                    width: size * 83,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size * 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * 24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImage.logo,
                    height: size * 18,
                    width: size * 18,
                  ),
                  SizedBox(
                    width: size * 9,
                  ),
                  SvgPicture.asset(
                    AppImage.listOfTodo,
                    height: size * 20,
                    width: size * 140,
                  ),
                  Spacer(),
                  GetBuilder<TodoController>(
                    builder: (controller) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          controller.updateView();
                        },
                        child: SvgPicture.asset(
                          controller.isGridView == false
                              ? AppImage.grid
                              : AppImage.column,
                          height: size * 20,
                          width: size * 140,
                          color: AppColor.secondColor,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: size * 9,
                  ),
                  PopupMenuButton(
                    splashRadius: 20,
                    icon: SvgPicture.asset(
                      AppImage.filter,
                      height: size * 24,
                      width: size * 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: size * 120,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    onSelected: (value) {
                      setState(() {
                        selectFilter = int.parse(value);
                      });
                    },
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          child: CommonText(
                            text: "All",
                            color: selectFilter == 0
                                ? AppColor.mainColor
                                : AppColor.black,
                            fontWeight: FontWeight.w900,
                          ),
                          value: '0',
                        ),
                        PopupMenuItem(
                          child: CommonText(
                            text: "By Time",
                            color: selectFilter == 1
                                ? AppColor.mainColor
                                : AppColor.black,
                            fontWeight: FontWeight.w900,
                          ),
                          value: '1',
                        ),
                        PopupMenuItem(
                          child: CommonText(
                            text: "Deadline ",
                            color: selectFilter == 2
                                ? AppColor.mainColor
                                : AppColor.black,
                            fontWeight: FontWeight.w900,
                          ),
                          value: '2',
                        )
                      ];
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: size * 17,
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: ValueListenableBuilder<Box<TaskAdd>>(
                  valueListenable: Boxes.addTask().listenable(),
                  builder: (context, value, child) {
                    final tasks =
                        value.values.toList().cast<TaskAdd>().toList();

                    return tasks.isEmpty
                        ? Center(
                            child: Text('No Task Available'),
                          )
                        : GetBuilder<TodoController>(
                            builder: (controller) {
                              return controller.isGridView == false
                                  ? ListView.separated(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15 * size),
                                      physics: BouncingScrollPhysics(),
                                      itemCount: tasks.length,
                                      itemBuilder: (context, index) {
                                        var data = tasks;

                                        final DateTime? date =
                                            tasks[index].time;
                                        var addingTime =
                                            DateFormat.yMMMMd().format(date!);
                                        if (selectFilter == 0 ||
                                            selectFilter == 1) {
                                          return showTaskList(data, index, size,
                                              font, addingTime, controller);
                                        } else {
                                          return data[index].isDeadline == true
                                              ? showTaskList(data, index, size,
                                                  font, addingTime, controller)
                                              : SizedBox();
                                        }
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: size * 16,
                                        );
                                      },
                                    )
                                  : MasonryGridView.count(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15 * size),
                                      itemCount: tasks.length,
                                      physics: BouncingScrollPhysics(),
                                      crossAxisCount: 2,
                                      itemBuilder: (context, index) {
                                        var data = tasks;

                                        final DateTime? date =
                                            tasks[index].time;
                                        var addingTime =
                                            DateFormat.yMMMMd().format(date!);
                                        if (selectFilter == 0 ||
                                            selectFilter == 1) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: showTaskList(
                                                data,
                                                index,
                                                size,
                                                font,
                                                addingTime,
                                                controller),
                                          );
                                        } else {
                                          return data[index].isDeadline == true
                                              ? showTaskList(data, index, size,
                                                  font, addingTime, controller)
                                              : SizedBox();
                                        }
                                      },
                                    );
                            },
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell showTaskList(List<TaskAdd> data, int index, double size, double font,
      String addingTime, TodoController controller) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        controller.updateSelectImageIndex(data[index].index!);
        print('---------------${data[index].index!}');
        Get.to(
            () => ShowTaskScreen(
                index: index, selectImageIndex: data[index].index!),
            transition: Transition.rightToLeft);
      },
      child: data[index].index == -1
          ? Container(
              height: 120 * size,
              // width: Get.width,
              decoration: BoxDecoration(
                color: data[index].isDeadline == true
                    ? AppColor.secondColor
                    : AppColor.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.only(
                  top: 6 * size,
                  bottom: 5 * size,
                  left: 16 * size,
                  right: 10 * size),
              child: showTaskInfo(data, index, font, size, addingTime),
            )
          : Container(
              height: 120 * size,
              // width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    controller.images[data[index].index!],
                  ),
                  fit: BoxFit.cover,
                ),
                color: data[index].isDeadline == true
                    ? AppColor.secondColor
                    : AppColor.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.only(
                  top: 6 * size,
                  bottom: 5 * size,
                  left: 16 * size,
                  right: 10 * size),
              child: showTaskInfo(data, index, font, size, addingTime),
            ),
    );
  }

  Column showTaskInfo(List<TaskAdd> data, int index, double font, double size,
      String addingTime) {
    print('--- data[index].isDeadline---${data[index].isDeadline}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CommonText(
                text: '${data[index].title}',
                fontSize: 16 * font,
                color: AppColor.white,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w900,
              ),
            ),
            data[index].isDeadline == true
                ? SvgPicture.asset(
                    AppImage.clock,
                    height: size * 16,
                    width: size * 16,
                  )
                : SizedBox(),
          ],
        ),
        Flexible(
          child: CommonText(
            text: '${data[index].description}',
            fontSize: 14 * font,
            color: AppColor.white,
            height: 2,
            maxLine: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CommonText(
          text: 'Created at ${addingTime}',
          fontSize: 11 * font,
          color: AppColor.white,
        ),
      ],
    );
  }

  void showAddTaskBottomSheet(
      {double? font, double? size, BuildContext? context}) {
    showModalBottomSheet(
      backgroundColor: AppColor.transparent,
      isScrollControlled: true,
      barrierColor: AppColor.transparent,
      context: context!,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return GetBuilder<TodoController>(
              builder: (controller) {
                return Container(
                  height: size! * 722,
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
                        inputTextSize: font! * 16,
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
                            if (controller.titleController.text.isEmpty) {
                            } else if (controller
                                .descriptionController.text.isEmpty) {
                            } else {
                              final taskAdd = TaskAdd();
                              taskAdd.deadline = controller.deadLine;
                              taskAdd.time = DateTime.now();
                              taskAdd.description =
                                  controller.descriptionController.text;

                              taskAdd.title = controller.titleController.text;
                              taskAdd.index = -1;
                              taskAdd.isDeadline =
                                  controller.deadLine == null ? false : true;

                              final box = Boxes.addTask();
                              box.add(taskAdd);
                            }

                            Get.back();
                            controller.clearAllValue();
                          },
                          buttonColor: AppColor.white,
                          radius: 12,
                          child: CommonText(
                            text: 'ADD TODO',
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
    ).whenComplete(() {
      todoController.clearAllValue();
    });
  }
}

///TASK ADD
// await FirebaseFirestore.instance
//     .collection('User')
//     .doc(kFirebaseAuth.currentUser!.uid)
//     .collection('Task')
//     .add({
//   'title': controller.titleController.text,
//   'description':
//       controller.descriptionController.text,
//   'deadline': controller.deadLine,
//   'isDeadline':
//       controller.deadLine == null ? false : true,
//   'time': DateTime.now()
// });

/// STREAM BUILDER
// StreamBuilder(
//   stream: FirebaseFirestore.instance
//       .collection('User')
//       .doc(kFirebaseAuth.currentUser!.uid)
//       .collection('Task')
//       .orderBy('time', descending: true)
//       .snapshots(),
//   builder: (BuildContext context,
//       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//           snapshot) {
//     if (snapshot.hasData) {
//       return snapshot.data!.docs.isEmpty
//           ? Center(
//               child: Text('No Task Available'),
//             )
//           : ListView.separated(
//               physics: BouncingScrollPhysics(),
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var data = snapshot.data!.docs;
//
//                 var timestamp = data[index]['time']
//                     .seconds; // timestamp in seconds
//                 final DateTime date =
//                     DateTime.fromMillisecondsSinceEpoch(
//                         timestamp * 1000);
//                 var addingTime =
//                     DateFormat.yMMMMd().format(date);
//                 if (selectFilter == 0 || selectFilter == 1) {
//                   return showTaskList(
//                       data, index, size, font, addingTime);
//                 } else {
//                   return data[index]['isDeadline'] == true
//                       ? showTaskList(
//                           data, index, size, font, addingTime)
//                       : SizedBox();
//                 }
//               },
//               separatorBuilder: (context, index) {
//                 return SizedBox(
//                   height: size * 16,
//                 );
//               },
//             );
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
