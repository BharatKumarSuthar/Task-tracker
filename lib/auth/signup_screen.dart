import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_tracker/services/supabase_service.dart';
import 'package:task_tracker/states/checkbox.dart';
import 'package:task_tracker/states/password_visibility.dart';
import 'package:task_tracker/auth/text_controller.dart';
import 'package:task_tracker/auth/login_screen.dart';
import 'package:task_tracker/utils/pageroute_animation.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1E1E1E),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/group.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Full Name",
                  style: TextStyle(fontSize: 16, color: Color(0xff8CAAB9)),
                ),
                SizedBox(height: 5),
                Container(
                  height: 48,
                  color: Color(0xff455A64),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset("assets/name.png", height: 22, width: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: ref.watch(name),
                          style: TextStyle(color: Colors.white, fontSize: 17),
                          maxLines: 1,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Name",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "Email Address",
                  style: TextStyle(fontSize: 16, color: Color(0xff8CAAB9)),
                ),
                SizedBox(height: 5),
                Container(
                  height: 48,
                  color: Color(0xff455A64),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset("assets/email.png", height: 22, width: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: ref.watch(email),
                          style: TextStyle(color: Colors.white, fontSize: 17),
                          maxLines: 1,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, color: Color(0xff8CAAB9)),
                ),
                SizedBox(height: 5),
                Container(
                  height: 48,
                  color: Color(0xff455A64),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Image.asset("assets/lock1.png", height: 22, width: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            return TextField(
                              controller: ref.watch(password),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              maxLines: 1,
                              obscureText: ref.watch(isVisible),
                              obscuringCharacter: '*',
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Consumer(
                        builder: (context, ref, child) {
                          final visibile = ref.watch(isVisible);
                          return GestureDetector(
                            onTap: () {
                              var visible = ref.read(isVisible.notifier).state;
                              if (visible) {
                                ref.read(isVisible.notifier).state = false;
                              } else {
                                ref.read(isVisible.notifier).state = true;
                              }
                            },
                            child:
                                visibile
                                    ? Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )
                                    : Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                          );
                        },
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final checked = ref.watch(isChecked);
                        if (checked) {
                          ref.watch(isChecked.notifier).state = false;
                        } else {
                          ref.watch(isChecked.notifier).state = true;
                        }
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffFED36A),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child:
                              ref.watch(isChecked)
                                  ? Icon(Icons.check, color: Color(0xffFED36A))
                                  : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "I have read & agreed to DayTask",
                                  style: TextStyle(
                                    color: Color(0xff8CAAB9),
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: " Privacy Policy",
                                  style: TextStyle(
                                    color: Color(0xffFED36A),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Terms & Condition",
                            style: TextStyle(
                              color: Color(0xffFED36A),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    var userEmail = ref.watch(email).text.trim();
                    var userPass = ref.watch(password).text.trim();
                    var userName = ref.watch(name).text.trim();
                    UserSignUp user = UserSignUp(
                      fullName: userName,
                      email: userEmail,
                      pass: userPass,
                      isChecked: ref.watch(isChecked),
                    );
                    await signUp(user, context);
                  },
                  child: Container(
                    height: 48,
                    color: Color(0xffFED36A),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(height: 2, color: Color(0xff8CAAB9)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Color(0xff8CAAB9)),
                      ),
                    ),
                    Expanded(
                      child: Divider(height: 2, color: Color(0xff8CAAB9)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/google.png", height: 24, width: 24),
                      SizedBox(width: 10),
                      Text(
                        "Google",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xff8CAAB9)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            RightToLeftRoute(page: const LoginScreen()),
                          );
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Color(0xffFED36A)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
