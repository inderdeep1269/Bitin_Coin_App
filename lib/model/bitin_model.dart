import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId = "";
  late String userName;
  late String userCoins;
  late String userRefers;
  late String userCoinMiningRate;
  late bool userIsActive;
  late DateTime clickTime;
  late bool userIsMining;

  UserModel(
      {required this.userName,
      required this.userCoins,
      required this.userRefers,
      required this.userCoinMiningRate,
      required this.userIsActive,
      required this.clickTime,
      required this.userIsMining});

  UserModel.fromDocumentSnapshot(DocumentSnapshot docSnap) {
    userId = docSnap.get('userId');
    userName = docSnap.get('userName');
    userCoins = docSnap.get('userCoins');
    userRefers = docSnap.get('userRefers');
    userCoinMiningRate = docSnap.get('userCoinMiningRate');
    userIsActive = docSnap.get('userIsActive');
    clickTime = docSnap.get('clickTime');
    userIsMining = docSnap.get('userIsMining');
  }
}
