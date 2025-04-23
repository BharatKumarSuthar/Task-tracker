import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/dashboard/dashboard_screen.dart';
import 'package:task_tracker/utils/const.dart';
import 'package:task_tracker/utils/pageroute_animation.dart';
import 'package:task_tracker/utils/validators.dart';
import 'package:task_tracker/auth/login_screen.dart';

class UserSignUp {
  bool isChecked = false;
  String fullName = "";
  String email = "";
  String pass = "";
  UserSignUp({
    required this.fullName,
    required this.email,
    required this.pass,
    required this.isChecked,
  });
}

class UserSignIn {
  String email = "";
  String pass = "";
  UserSignIn({required this.email, required this.pass});
}

//Sign Up
Future<void> signUp(UserSignUp user, BuildContext context) async {
  try {
    if (user.fullName.isEmpty) {
      throw NameException(message: "Username cannot be empty.");
    }
    if (!user.isChecked) {
      throw TermException(message: "Accept term & conditions.");
    }
    await Supabase.instance.client.auth.signUp(
      email: user.email,
      password: user.pass,
    );
    var pref = await SharedPreferences.getInstance();
    pref.setString(USER, user.fullName);
    Navigator.pushReplacement(
      context,
      RightToLeftRoute(page: const LoginScreen()),
    );
  } on AuthApiException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message, style: TextStyle(fontSize: 17))),
    );
  } on NameException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message, style: TextStyle(fontSize: 17))),
    );
  } on TermException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message, style: TextStyle(fontSize: 17))),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error", style: TextStyle(fontSize: 17))),
    );
  }
}

//Log In
Future<void> signIn(UserSignIn user, BuildContext context) async {
  try {
    await Supabase.instance.client.auth.signInWithPassword(
      email: user.email,
      password: user.pass,
    );
    var pref = await SharedPreferences.getInstance();
    pref.setBool(IS_LOGGED_IN, true);
    Navigator.pushReplacement(
      context,
      RightToLeftRoute(page: const DashboardScreen()),
    );
  } on AuthApiException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message, style: TextStyle(fontSize: 17))),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error", style: TextStyle(fontSize: 17))),
    );
  }
}

//Log Out
Future<void> logOut({required BuildContext context}) async {
  try {
    await Supabase.instance.client.auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Logged Out Successfully.",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error", style: TextStyle(fontSize: 17))),
    );
  }
}
