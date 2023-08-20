import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagrampj/models/user_model.dart' as model;
import 'package:instagrampj/utils/utils.dart';

class FirestoreFeature {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> getUserRealtimeStream(String? uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  Future<String> addUserToFireStore(model.User user) async {
    String res = "";
    try {
      await _store
          .collection('users')
          .doc(user.uId)
          .set(user.toJson())
          .whenComplete(() => res = 'create account succeed');
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
  Future<bool> updateData({required String collectionName, required String docName,required String keyUpdate,required dynamic valueUpdate})async{
    final ref = _store.collection(collectionName).doc(docName);
    ref.update({keyUpdate: valueUpdate}).then(
            (value) {
              print("DocumentSnapshot $docName -> $keyUpdate:$valueUpdate successfully updated!");
              return true;
              },
        onError: (e) {
          print("Error updating document $e");
          return false;
        } );
    return false;
  }

}
