import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:instagrampj/resources/auth.dart';
import 'package:instagrampj/utils/utils.dart';
import 'package:instagrampj/widgets/dropdown_languge.dart';
import '../../utils/colors.dart';
import '../../widgets/text_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  void _validate() {
    _form.currentState?.validate();
  }

  final TextEditingController _mailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;
  bool _checkConfirmPass(){
    if(_confirmPassController.text==_passController.text){
      return true;
    }
    else return false;
  }
  Future<void> signupAccount() async {
    if(_checkConfirmPass()){
      setState(() {
        _isLoading = true;
      });
      String res = await AuthFeature().signupUser(mail: _mailController.text,
          fullName: _nameController.text,
          pass: _passController.text);
      if(res =='create account succeed'){
        setState(() {
          _isLoading=false;
        });
        if(context.mounted){
          showSnackBar(context, 'Create account succeed.');
        }
      }
      else if(res =='enter all feild'){
        setState(() {
          _isLoading = false;
        });
        if(context.mounted){
          showSnackBar(context, 'Please enter all field.');

        }
      }
      else {
        setState(() {
          _isLoading = false;
        });
        if(context.mounted){
          showSnackBar(context, 'Some errror occurred.');
        }
      }
    }
    else{
      showSnackBar(context, 'Confirm password does not match.');
    }
  }
  final _validateMail = ValidationBuilder().minLength(12).maxLength(50).email().build();
  final _validateName = ValidationBuilder().minLength(4).maxLength(50).build();
  final _validatePass = ValidationBuilder().minLength(6).maxLength(50).build();
  final _validateConfirmPass = ValidationBuilder().minLength(6).maxLength(50).build();

  @override
  Widget build(BuildContext context) {
    final double deviseWidth = MediaQuery
        .of(context)
        .size
        .width;
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
                  TextFormWidget(controller: _nameController, hint: 'Full Name',validate: _validateName,obscureText: false,inputType: TextInputType.text,),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormWidget(
                    controller: _mailController, hint: 'Email ',validate: _validateMail,obscureText: false,inputType: TextInputType.emailAddress,),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormWidget(controller: _passController, hint: 'Password',validate: _validatePass,obscureText: true,inputType: TextInputType.text,),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormWidget(
                      controller: _confirmPassController, hint: 'Confirm password',validate: _validateConfirmPass,obscureText: true,inputType: TextInputType.text,),
                  SizedBox(height: 32,),
                  InkWell(
                    onTap: () {
                      _validate();
                      signupAccount();
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
                            "Sign up",
                            style: TextStyle(
                                color: primaryColor, fontWeight: FontWeight.w600),
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
                    onTap: null,
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
                              Icon(Icons.facebook, color: Colors.white,),
                              SizedBox(width: 12,),
                              Text(
                                "Log in with Facebook",
                                style: TextStyle(color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
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
                Divider(thickness: 1, color: Color.fromRGBO(0, 0, 0, 0.2),),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?", style: TextStyle(
                          fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.4)),),
                      Text("Sign in now",
                        style: TextStyle(fontSize: 14, color: secondaryColor),),
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

