import 'package:cloud_firestore/cloud_firestore.dart';
class User {
  late String? mail;
  late String? fullName;
  late String? userName;
  late String? uId;
  late String? urlPhotos;
  late List<String>? followers;
  late List<String>? following;
  late List<String>? roomChats;
  late List<String>? posts;
  late List<String>? stories; // Thêm thuộc tính stories kiểu List<String> vào đây
  late String? bio;
  late String? numbPhone;
  late String? gender;
  User({
    this.mail,
    this.fullName,
    this.userName,
    this.uId,
    this.urlPhotos,
    this.followers,
    this.following,
    this.roomChats,
    this.posts,
    this.stories, // Thêm trường dữ liệu cho stories vào đây
    this.bio,
    this.numbPhone,
    this.gender,
  });

  factory User.fromFirestore(DocumentSnapshot<Object?> snapshot, SnapshotOptions? options) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return User(
      mail: data?['mail'],
      fullName: data?['fullName'],
      userName: data?['userName'],
      uId: data?['uId'],
      urlPhotos: data?['urlPhotos'],
      followers: data?['followers'] is Iterable ? List.from(data?['followers']) : null,
      following: data?['following'] is Iterable ? List.from(data?['following']) : null,
      roomChats: data?['roomChats'] is Iterable ? List.from(data?['roomChats']) : null,
      posts: data?['posts'] is Iterable ? List.from(data?['posts']) : null,
      stories: data?['stories'] is Iterable ? List.from(data?['stories']) : null, // Thêm trường dữ liệu cho stories vào đây
      bio: data?['bio'],
      numbPhone: data?['numbPhone'],
      gender: data?['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mail': mail,
      'fullName': fullName,
      'userName': userName,
      'uId': uId,
      'urlPhotos': urlPhotos,
      'followers': followers,
      'following': following,
      'roomChats': roomChats,
      'posts': posts,
      'stories': stories, // Thêm thuộc tính stories vào đây
      'bio': bio,
      'numbPhone': numbPhone,
      'gender': gender,
    };
  }
}
