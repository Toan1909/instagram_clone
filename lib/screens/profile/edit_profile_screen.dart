import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagrampj/utils/utils.dart';
import '../../get/user_data_controller.dart';
import '../../utils/colors.dart';
import '../common_widget/circle_img_with_text_widget.dart';
import '../../models/user_model.dart' as model;
class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final double _heightForm = 60;

  final fullNameEditController = TextEditingController();

  final nameUserEditController = TextEditingController();

  final bioEditController = TextEditingController();

  final emailEditController = TextEditingController();

  final phoneEditController = TextEditingController();
  final genEditController = TextEditingController();
  String? selectedGender;
  final UserController userController = Get.find<UserController>();
  @override
  void initState() {
    model.User userData = userController.user.value;
    fullNameEditController.text =userData.fullName!;
    nameUserEditController.text = userData.userName!;
    bioEditController.text = userData.bio!;
    emailEditController.text = userData.mail!;
    phoneEditController.text = userData.numbPhone!;
    genEditController.text = userData.gender!;
     // selectedGender = userData.gender;

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.2,
        leading: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //color: Colors.grey,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        title: const Text(
          "Edit profile",
          style: TextStyle(
              color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions:  [
          InkWell(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text('Confirmation'),
                  content: const Text('Are you sure you want to update info?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back(result: false); // Trả về giá trị 'false' khi chọn No
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(result: true); // Trả về giá trị 'true' khi chọn Yes
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ).then((value) async {
                bool isUpdated = false;
                // Xử lý giá trị trả về từ dialog ở đây
                if(fullNameEditController.text!=userController.user.value.fullName){
                  if (value != null && value == true) {
                    userController.firestoreFeature.updateData(
                        collectionName: "users",
                        docName: userController.user.value.uId??"",
                        keyUpdate: "fullName",
                        valueUpdate: fullNameEditController.text);
                    isUpdated = true;
                  } else {
                    // Thực hiện hành động khi chọn No hoặc đóng dialog
                    print('Canceled update');
                    isUpdated = false;
                  }
                }
                if(nameUserEditController.text!=userController.user.value.userName){
                  if (value != null && value == true) {
                    userController.firestoreFeature.updateData(
                        collectionName: "users",
                        docName: userController.user.value.uId??"",
                        keyUpdate: "userName",
                        valueUpdate: nameUserEditController.text);
                    isUpdated = true;
                  } else {
                    // Thực hiện hành động khi chọn No hoặc đóng dialog
                    print('Canceled update');
                    isUpdated = false;
                  }
                }
                if(bioEditController.text!=userController.user.value.bio){
                  if (value != null && value == true) {
                    userController.firestoreFeature.updateData(
                        collectionName: "users",
                        docName: userController.user.value.uId??"",
                        keyUpdate: "bio",
                        valueUpdate: bioEditController.text);
                    isUpdated = true;
                  } else {
                    // Thực hiện hành động khi chọn No hoặc đóng dialog
                    print('Canceled update');
                    isUpdated = false;
                  }
                }
                if(selectedGender!=userController.user.value.gender){
                  if (value != null && value == true) {
                    userController.firestoreFeature.updateData(
                        collectionName: "users",
                        docName: userController.user.value.uId??"",
                        keyUpdate: "gender",
                        valueUpdate: selectedGender);
                    isUpdated = true;
                  } else {
                    // Thực hiện hành động khi chọn No hoặc đóng dialog
                    print('Canceled update');
                    isUpdated = false;
                  }
                }
                if(isUpdated){
                  showSnackBar(context, "Your information is updated.");
                }
              });
            },
            child: const Text("Done",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),

          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: CircleImageWithTextUnder(
                  haveStory: false,
                  size: 96,
                  urlImg: "assets/avt_default.png",
                  text: "",
                  callback: () {},
                ),
              ),
              const Text(
                "Change Profile Photo",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: secondaryColor),
              )
            ],
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(60, 60, 67, 0.18),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Column(
              children: [
                Container(
                  height: _heightForm,
                  child: TextFormField(
                    controller: fullNameEditController,
                    style: const TextStyle(

                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        height: 1.8),
                    decoration: const InputDecoration(
                      labelText: ("Name"),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "Full name",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(60, 60, 60, 0.8)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  height: _heightForm,
                  child: TextFormField(
                    controller: nameUserEditController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        height: 1.8),
                    decoration: const InputDecoration(
                      labelText: ("Name user"),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "Name user",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(60, 60, 60, 0.8)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  height: _heightForm,
                  child: TextFormField(
                    controller: genEditController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        height: 1.8),
                    decoration: const InputDecoration(
                      labelText: ("Gender"),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(60, 60, 60, 0.8)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 12),
                  child: DropdownButton<String>(
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                        genEditController.text = selectedGender!;
                      });
                    },
                    items: <String>['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text('Select Gender'),
                  ),
                ),
                Container(
                  height: _heightForm,
                  child: TextFormField(
                    controller: bioEditController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        height: 1.8),
                    decoration: const InputDecoration(
                      labelText: ("Bio"),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "Your biography",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(60, 60, 60, 0.8)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(60, 60, 67, 0.18),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                    child: const Text(
                  "Switch to Professional Account",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor),
                )),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Private infomation",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor),
                    )),
                Container(
                  height: _heightForm,
                  child: TextFormField(
                    controller: emailEditController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        height: 1.8),
                    decoration: const InputDecoration(
                      labelText: ("Email"),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "example@gmail.com",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(60, 60, 60, 0.8)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  height: _heightForm,
                  child: TextFormField(
                    controller: phoneEditController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        height: 1.8),
                    decoration: const InputDecoration(
                      labelText: ("Phone"),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "Number phone",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color.fromRGBO(60, 60, 60, 0.8)),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
