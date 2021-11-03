import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  late String userName;
  late String referUsername;
  late String email;

  UserData({
    required this.userName,
    required this.referUsername,
    required this.email,
  });

  UserData.fromDocumentSnapshot(DocumentSnapshot docSnap) {
    userName = docSnap.get('userName');
    referUsername = docSnap.get('referUsername');
    email = docSnap.get('email');
  }
}