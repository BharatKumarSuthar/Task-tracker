import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/dashboard/exception.dart';
import 'package:task_tracker/dashboard/providers.dart';
import 'package:task_tracker/dashboard/task_model.dart';
import 'package:task_tracker/dashboard/text_controller.dart';
import 'package:task_tracker/repositery/add_task.dart';

Future<dynamic> addTaskBottomSheet({required BuildContext context}) async {
  final List<String> list = ["Pending", "Completed"];
  return showModalBottomSheet(
    constraints: BoxConstraints(maxHeight: 600),
    backgroundColor: Color(0xff1E1E1E),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (cnt) {
      return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 4),
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  padding: EdgeInsets.all(7),
                  color: Color(0xff455A64),
                  child: TextField(
                    //maxLength: 40,
                    controller: ref.watch(title),
                    maxLines: 2,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      isDense: true,
                      hintText: "Max character 40...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              "Status",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 4),
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  padding: EdgeInsets.all(3),
                  color: Color(0xff455A64),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ref.watch(status),
                          readOnly: true,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                            isDense: true,
                            hintText: "Task status",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton(
                        onSelected: (value) {
                          ref.read(textProvider.notifier).state = value;
                        },
                        color: Color(0xff455A64),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 45,
                        ),
                        itemBuilder: (context) {
                          return list.map((e) {
                            return PopupMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            Consumer(
              builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () async {
                    final taskTitle = ref.watch(title).text;
                    final taskStatus = ref.watch(status).text;
                    try {
                      if (taskTitle.isNotEmpty && taskStatus.isNotEmpty) {
                        TaskModel model = TaskModel(
                          title: taskTitle,
                          status: taskStatus,
                        );
                        await addTask(model);
                        ref.read(taskProvider.notifier).addTask(model);
                        ref.read(title).text = "";
                        ref.read(textProvider.notifier).state = "";

                        Navigator.pop(context);
                      } else {
                        throw FillData(
                          message: "Title and Status cannot be empty.",
                        );
                      }
                    } on FillData catch (e) {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Color(0xff455A64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Colors.black,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              constraints: BoxConstraints(maxHeight: 170),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.message,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 7,
                                          ),

                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 55,
                    color: Color(0xffFED36A),
                    child: Center(
                      child: Text(
                        "Add Task",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
