import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/app/theme.dart';
import 'package:task_tracker/dashboard/dashboard_screen.dart';
import 'package:task_tracker/utils/pageroute_animation.dart';
import 'package:task_tracker/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://melbpxohwvggmzcdugrc.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1lbGJweG9od3ZnZ216Y2R1Z3JjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyMjE1NzYsImV4cCI6MjA2MDc5NzU3Nn0.RVxeHmV0jeRI0sVRpP0jhnzlbX90Ba4i0HITcK6Owuc",
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    readData();
    super.initState();
  }

  //shared preferences
  void readData() async {
    var pref = await SharedPreferences.getInstance();
    var logIn = pref.getBool("isLoggedIn") ?? false;
    if (!logIn) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          RightToLeftRoute(page: const LoginScreen()),
        );
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          RightToLeftRoute(page: const DashboardScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/group.png", height: 100),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                color: Colors.white,
                child: Image.asset(
                  "assets/pana.png",
                  height: 250,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
              Image.asset(
                "assets/heading.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
