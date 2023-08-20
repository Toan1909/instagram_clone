import 'package:flutter/material.dart';
import 'package:instagrampj/screens/auth/login_screen_second.dart';
import 'package:instagrampj/screens/main_instagram.dart';
import '../../utils/colors.dart';
import '../../widgets/dropdown_languge.dart';

class LoginFirstWidget extends StatelessWidget {
  LoginFirstWidget({super.key});

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final double deviseWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownLanguage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: deviseWidth * 0.5,
                ),
                SizedBox(
                  height: 64,
                ),
                SizedBox(
                  width: 86,
                  height: 86,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avt_default.png'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "ndt1909_opppp",
                  style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainDisplay()));
                  },
                  child: Center(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: ShapeDecoration(
                          color: secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Container(
                        child: !_isLoading
                            ? const Text(
                                "Log in",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              )
                            : SizedBox(
                                width: 32,
                                child:
                                    Center(child: CircularProgressIndicator())),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Divider(
                          endIndent: 5,
                          thickness: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        )),
                    Text(
                      "OR",
                      style: TextStyle(
                          fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.4)),
                    ),
                    Flexible(
                        flex: 1,
                        child: Divider(
                          indent: 5,
                          thickness: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginSecondWidget()));
                  },
                  child: const Text(
                    "Switch accounts",
                    style: TextStyle(fontSize: 14, color: secondaryColor,fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(
                  thickness: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't hava an account?",
                        style: TextStyle(
                            fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.4)),
                      ),
                      Text(
                        "Sign up",
                        style: TextStyle(fontSize: 12, color: secondaryColor),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
