import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:instagrampj/models/user_model.dart' as model;
import 'package:instagrampj/resources/firestore.dart';
import 'package:instagrampj/utils/utils.dart';

class AuthFeature {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get uid => _auth.currentUser?.uid;
  Future<String> signupUser({
    required String mail,
    required String fullName,
    required String pass,
  }) async {
    FirestoreFeature firestoreFeature= Get.find<FirestoreFeature>();
    String res = "";
    try {
      if (mail.isNotEmpty && fullName.isNotEmpty && pass.isNotEmpty) {
        //register account in auth
        final credential = await _auth.createUserWithEmailAndPassword(
          email: mail,
          password: pass,
        );
        //create a object user
        model.User user = model.User(
            mail: mail,
            fullName: fullName,
            userName: 'user' + idGenerator(),
            uId: credential.user!.uid,
            urlPhotos: 'url',
            followers: [],
            following: [],
            roomChats: [],
            stories: [],
            posts: [],
            bio: "",
            numbPhone: "",
          gender: "",
        );
        res = await firestoreFeature.addUserToFireStore(user);
        //create data account in firestore

      } else
        res = 'enter all feild';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String mail,
    required String pass,
  }) async {
    //String res = "Some errror occurred when login";
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: mail,
          password: pass
      );

      return "succeed-login";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "user-not-found";
              }//not working
      else if (e.code == "wrong-password") {
        return "wrong-password";
      }
      else return "jjj";//not working
    }

  }
  Future<void> signOut() async{
    await _auth.signOut();
  }
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  Future<String> loginUserWithCredential() async {
    //String res = "Some errror occurred when login";
    try {
      final credential = await signInWithFacebook();
      _createUserUseSocialAuth(credential);
      return "succeed-login";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "user-not-found";
      }//not working
      else if (e.code == "wrong-password") {
        return "wrong-password";
      }
      else return "error";//not working
    }

  }
  Future<void> _createUserUseSocialAuth(UserCredential credential) async {
    FirestoreFeature firestoreFeature= Get.find<FirestoreFeature>();
    if (credential.user != null) {
      for (final providerProfile in credential.user!.providerData) {
        // ID of the provider (google.com, apple.com, etc.)
        final provider = providerProfile.providerId;

        // UID specific to the provider
        final uid = providerProfile.uid!;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName!;
        final emailAddress = providerProfile.email!;
        final profilePhoto = providerProfile.photoURL;
        model.User user = model.User(
            mail: emailAddress,
            fullName: name,
            userName: 'user' + idGenerator(),
            uId: uid,
            urlPhotos: 'url',
            followers: [],
            following: [],
            roomChats: [],
            posts: []);
        //create data account in firestore
        firestoreFeature.addUserToFireStore(user);

      }
    }
  }
}


