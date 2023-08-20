import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagrampj/get/user_data_controller.dart';
import 'package:instagrampj/resources/auth.dart';
import 'package:instagrampj/resources/firestore.dart';
import 'package:instagrampj/screens/main_instagram.dart';
import 'firebase_options.dart';
import 'package:instagrampj/responsive/mobile_responsive.dart';
import 'package:instagrampj/utils/colors.dart';
Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitFirebase();
  runApp(MyApp());

}
Future<void> InitFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Đăng ký đối tượng AuthFeature vào GetX Dependency Injection Container
    Get.put<AuthFeature>(AuthFeature());

    // Đăng ký đối tượng FirestoreFeature vào GetX Dependency Injection Container
    Get.put<FirestoreFeature>(FirestoreFeature());

    print("init firebase ok");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
}
class MyApp extends StatelessWidget {
  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var controllerUser = Get.put(UserController());
    return GetMaterialApp(
      title: 'Instagram ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              controllerUser.getDataUserRealtime();
              return MainDisplay();
            }
            else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }
          }
          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Center(child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(),
            ));
          }
          return AuthScreens();
        },

      )
      // const MobileScreen(),
    );
  }
}
