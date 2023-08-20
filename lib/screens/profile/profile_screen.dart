import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagrampj/get/user_data_controller.dart';
import 'package:instagrampj/screens/profile/edit_profile_screen.dart';
import 'package:instagrampj/screens/profile/tabbar_post_profile.dart';
import 'package:instagrampj/utils/colors.dart';
import '../common_widget/circle_img_with_text_widget.dart';
import '../common_widget/counter_info.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var isDrawerOpen = false.obs;
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key :_scaffoldKey,
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.6,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //color: Colors.grey,
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                size: 14,
                color: textColor,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        "${userController.user.value.userName}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 14,
                      color: textColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: InkWell(
              onTap: () {

              },
              child: const Icon(
                Icons.add_box_outlined,
                color: textColor,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: const Icon(
                Icons.menu_outlined,
                color: textColor,
              ),
            ),
          )
        ],
      ),
      endDrawer: Obx(() {
        if(!isDrawerOpen.value){
          return Container(
            child: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text('Drawer Header')),
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      // Thực hiện các thao tác khi người dùng chọn Item 1
                      isDrawerOpen.value = false;
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Thực hiện các thao tác khi người dùng chọn Item 1
                      isDrawerOpen.value = false;
                    },

                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log out'),
                    onTap: () {
                      // Thực hiện các thao tác khi người dùng chọn Item 1
                      isDrawerOpen.value = false;
                      userController.authFeature.signOut();
                      Navigator.pop(context);
                    },

                  ),
                ],
              ),
            ),
          );
        }
        else {
          return Container();
        }
        }),
      body: Container(
        child: Container(
          //height: MediaQuery.of(context).size.height*0.39,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          final userModel = userController.user.value;
                          print("${userModel.fullName}");
                          return CircleImageWithTextUnder(
                            size: 96,
                            urlImg: "assets/avt_default.png",
                            text: userModel.fullName ?? "",
                            callback: () {},
                          );
                        }),
                        Obx(() => Container(
                            width: 120,
                            child: Text(
                              userController.user.value.bio!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14),
                            )))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(
                          () => CounterInfoWidget(
                            quantity: userController.user.value.posts?.length,
                            name: "Post",
                          ),
                        ),
                        Obx(
                          () => CounterInfoWidget(
                            quantity:
                                userController.user.value.followers?.length,
                            name: "Follower",
                          ),
                        ),
                        Obx(
                          () => CounterInfoWidget(
                            quantity:
                                userController.user.value.following?.length,
                            name: "Following",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen()));
                      },
                      child: Center(
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: ShapeDecoration(
                              color: const Color.fromRGBO(250, 250, 250, 1),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Color.fromRGBO(60, 60, 67, 0.18),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text("Edit profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: ShapeDecoration(
                              color: const Color.fromRGBO(250, 250, 250, 1),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Color.fromRGBO(60, 60, 67, 0.18),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text("Share profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromRGBO(60, 60, 67, 0.18),
                            width: 1,
                          )),
                      child: IconButton(
                        iconSize: 16,
                        onPressed: () {},
                        icon: const Icon(Icons.add_reaction_outlined),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                //color: Colors.yellow,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromRGBO(60, 60, 67, 0.18),
                            width: 1),
                      ),
                      child: const Icon(Icons.add, size: 46),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 90,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircleImageWithTextUnder(
                                size: 64,
                                urlImg: "assets/avt_default.png",
                                text: "Nguyễn Toàn",
                                callback: () {},
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color.fromRGBO(60, 60, 67, 0.18),
              ),
              const Expanded(
                child: TabBarPostsProfile(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
