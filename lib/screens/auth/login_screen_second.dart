import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:instagrampj/resources/auth.dart';
import 'package:instagrampj/screens/auth/signup_screen.dart';
import 'package:instagrampj/screens/main_instagram.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../../widgets/dropdown_languge.dart';
import '../../widgets/text_input_widget.dart';

class LoginSecondWidget extends StatefulWidget {
  const LoginSecondWidget({
    super.key,
  });

  @override
  State<LoginSecondWidget> createState() {
    return _LoginSecondWidgetState();
  }
}

class _LoginSecondWidgetState extends State<LoginSecondWidget> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    _form.currentState?.validate();
  }

  final TextEditingController _mailController = TextEditingController();

  final TextEditingController _passController= TextEditingController();

  bool _isLoading= false;

  final _validateMail = ValidationBuilder().minLength(12).maxLength(50).email().build();

  final _validatePass = ValidationBuilder().minLength(6).maxLength(50).build();

  void _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthFeature().loginUser(mail: _mailController.text, pass: _passController.text);
    if(res =="succeed-login"){
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainDisplay()));
    }
    else if(res=="user-not-found"){
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, 'User not found :((');
    }
    else if(res == "wrong-password"){
      setState(() {
        _isLoading = false;
      });
      if(context.mounted){
        showSnackBar(context, 'Wrong password :((');
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      if(context.mounted){
        showSnackBar(context, 'Some errror occurred when login');
      }
    }
  }
  void _loginUserFb() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthFeature().loginUserWithCredential();
    if(res =="succeed-login"){
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainDisplay()));
    }
    else if(res=="user-not-found"){
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, 'User not found :((');
    }
    else if(res == "wrong-password"){
      setState(() {
        _isLoading = false;
      });
      if(context.mounted){
        showSnackBar(context, 'Wrong password :((');
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      if(context.mounted){
        showSnackBar(context, 'Some errror occurred when login');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final double deviseWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownLanguage(),
            Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: deviseWidth * 0.5,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormWidget(
                    validate: _validateMail,
                    controller: _mailController,
                    hint: 'Phone numbers, Email or Username', obscureText: false, inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormWidget(validate: _validatePass,controller: _passController, hint: 'Password',obscureText: true,inputType: TextInputType.text,),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.topRight,
                      child: const TextButton(
                          onPressed: null,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(color: secondaryColor),
                          ))),
                  InkWell(
                    onTap: (){
                      _validate();
                      _loginUser();
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
                            style: TextStyle(color: primaryColor,fontWeight: FontWeight.w600),
                          )
                              : SizedBox(
                              width: 32,
                              child: Center(
                                  child: CircularProgressIndicator())),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
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
                  SizedBox(height: 16,),
                  InkWell(
                    onTap: (){
                      _loginUserFb();
                      showSnackBar(context, "loginfacebook");
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook,color: Colors.white,),
                              SizedBox(width: 12,),
                              Text(
                                "Log in with Facebook",
                                style: TextStyle(color: primaryColor,fontWeight: FontWeight.w600),
                              ),
                            ],
                          )

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(thickness: 1,color: Color.fromRGBO(0, 0, 0, 0.2),),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't hava an account?",style: TextStyle(fontSize: 14,color: Color.fromRGBO(0, 0, 0, 0.4)),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        },
                          child: Text("Sign up",style: TextStyle(fontSize: 14,color: secondaryColor),)),
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

