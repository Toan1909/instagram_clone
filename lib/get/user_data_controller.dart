import 'package:get/get.dart';
import 'package:instagrampj/models/user_model.dart' as model;
import 'package:instagrampj/resources/auth.dart';
import 'package:instagrampj/resources/firestore.dart';

class UserController extends GetxController {
  final AuthFeature authFeature = Get.find<AuthFeature>();
  final FirestoreFeature firestoreFeature = Get.find<FirestoreFeature>();
  var user = model.User().obs;
  //var isLoading= true.obs;
  @override
  void onInit() {
    super.onInit();
    getDataUserRealtime();
  }

  void getDataUserRealtime() {
    try{
      //isLoading.value = true;// variable mean start loading data
      firestoreFeature.getUserRealtimeStream(authFeature.uid).listen((event) {
        if (event.exists) {
          user.value = model.User.fromFirestore(event, null);//update data
          print("Fetch Data User ${user.value.fullName} done");
        }
      });
    }
    catch(e){
      print("Error at getDataUserRealtime() : $e");
    }
  }
}
