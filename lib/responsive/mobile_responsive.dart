import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagrampj/screens/auth/login_screen_first.dart';
import 'package:instagrampj/screens/main_instagram.dart';
import '../screens/auth/login_screen_second.dart';


class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});
  @override
  State<AuthScreens> createState() => _AuthScreensState();
}
class _AuthScreensState extends State<AuthScreens> {
  bool _isAlreadyLogin =false;
  @override
  Widget build(BuildContext context) {
    double deviseWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: _isAlreadyLogin?LoginFirstWidget():LoginSecondWidget()//LoginSecondWidget(deviseWidth: deviseWidth, mailController: _mailController, passController: _passController, isLoading: _isLoading),
      ),
    );
  }
}

