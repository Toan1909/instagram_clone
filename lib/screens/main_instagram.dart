import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:instagrampj/get/user_data_controller.dart';
import 'package:instagrampj/resources/auth.dart';
import 'package:instagrampj/screens/auth/login_screen_second.dart';
import 'package:instagrampj/screens/newfeed/newfeed_screen.dart';
import 'package:instagrampj/screens/profile/profile_screen.dart';
import 'package:instagrampj/utils/colors.dart';
import 'package:instagrampj/models/user_model.dart' as model;
class MainDisplay extends StatefulWidget {
  MainDisplay({super.key});

  @override
  State<StatefulWidget> createState() => StateOfMain();
}

class StateOfMain extends State<MainDisplay> {
  final _pageViewController = PageController();
  int _activePage = 0;
  UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: PageView(
            controller: _pageViewController,
            children: <Widget>[
              NewFeedScreen(),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.deepPurple,
              ),
              Container(
                color: Colors.grey,
              ),
              ProfileScreen(),
            ],
            onPageChanged: (index) {
              setState(() {
                _activePage = index;
              });
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                _activePage != 0 ? Icon(Icons.home_outlined) : Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _activePage != 3
                ? Icon(Icons.favorite_border_outlined)
                : Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _activePage != 4?Icon(Icons.person_outline):Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _activePage,
        unselectedIconTheme: IconThemeData(
          color: textColor,
          size: 24,
        ),
        selectedIconTheme: IconThemeData(color: textColor, size: 26),
        selectedFontSize: 14,
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.bounceOut);
        },
      ),
    );
  }
}
