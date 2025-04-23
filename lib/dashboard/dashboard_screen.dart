import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker/dashboard/bottom_sheet.dart';
import 'package:task_tracker/dashboard/providers.dart';
import 'package:task_tracker/dashboard/task_tile.dart';
import 'package:task_tracker/services/supabase_service.dart';
import 'package:task_tracker/utils/const.dart';
import 'package:task_tracker/utils/pageroute_animation.dart';
import 'package:task_tracker/auth/login_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFED36A),
        title: Text("Task Tracker"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Builder(
              builder: (cnt) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(cnt).openDrawer();
                  },
                  child: CircleAvatar(child: Image.asset("assets/profile.png")),
                );
              },
            ),
          ),
        ],
      ),
      body:
          tasks.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: tasks.length + 1,
                itemBuilder: (_, index) {
                  if (index != tasks.length) {
                    return taskCard(context, tasks[index], index);
                  } else {
                    return SizedBox(height: 50);
                  }
                },
              ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffFED36A),
        onPressed: () {
          addTaskBottomSheet(context: context);
        },
        child: Icon(Icons.add, color: Colors.black, size: 40),
      ),
      drawer: drawer(context: context),
      drawerEdgeDragWidth: 200,
    );
  }
}

//Drawer
Widget drawer({required BuildContext context}) {
  return Container(
    color: Color(0xff455A64),
    width: 270,
    child: Column(
      children: [
        Image.asset("assets/userprofile.png", height: 200, width: 200),
        Consumer(
          builder: (context, ref, child) {
            final useName = ref.watch(nameProvider);
            return useName.when(
              data: (data) {
                return Text(
                  data!,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
              error: (err, snp) {
                return Text("error");
              },
              loading: () => CircularProgressIndicator(),
            );
          },
        ),
        Divider(height: 3, color: Colors.white),
        SizedBox(height: 25),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(width: 24),
              Icon(Icons.light_mode, size: 33),
              SizedBox(width: 15),
              Text(
                "Light Mode",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ],
          ),
        ),
        SizedBox(height: 35),
        GestureDetector(
          onTap: () async {
            await logOut(context: context);
            final pref = await SharedPreferences.getInstance();
            pref.setBool(IS_LOGGED_IN, false);
            Navigator.pushReplacement(
              context,
              RightToLeftRoute(page: const LoginScreen()),
            );
          },
          child: Row(
            children: [
              SizedBox(width: 24),
              Icon(Icons.logout, size: 33),
              SizedBox(width: 15),
              Text(
                "Log Out",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
