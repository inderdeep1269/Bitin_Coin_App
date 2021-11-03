import 'package:bitin_coin_app/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bitin_coin_app/model/bitin_model.dart';

class DatabaseService {
  final firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getMiners({required String uid}) {
    try {
      return firestore
          .collection('BitinMiners')
          .doc(uid)
          .collection('UserData')
          .snapshots()
          .map((friends) {
        List<UserModel> minerFriends = [];
        for (final DocumentSnapshot friend in friends.docs) {
          minerFriends.add(UserModel.fromDocumentSnapshot(friend));
        }
        return minerFriends;
      });
    } catch (e) {
      rethrow;
    }
  }

  bool doesUsernameExists(String username) {
    bool getBool = false;
    final usernames = firestore
              .collection('CurrentUsers')
              .where('Username', isEqualTo: username);
      usernames.snapshots().map((friends) {
        if (friends.docs.isEmpty) {
          getBool = false;
        }
        else {
          getBool = true;
        }
      });
    return getBool;
  }
  bool doesEmailExists(String email) {
    bool getBool = false;
    final usernames = firestore
              .collection('CurrentUsers')
              .where('Email', isEqualTo: email);
      usernames.snapshots().map((friends) {
        if (friends.docs.isEmpty) {
          getBool = false;
        }
        else {
          getBool = true;
        }
      });
    return getBool;
  }


  Future<bool> checkForReferUser(String referUsername) async {
    bool getBool = false;
    QuerySnapshot userData = await firestore.collection('CurrentUsers').where('Username', isEqualTo: referUsername).get();
    List<UserData> name = [];

    for(var data in userData.docs) {
      name.add(UserData(
        userName: data.get('Username'),
        referUsername: data.get('ReferUsername'),
        email: data.get('Email')
      ));
    }

    return name.isNotEmpty;
  }

  bool isUserExists(String username, String email) {
    bool getBool = false;
    final usernames = firestore
        .collection('CurrentUsers')
        .where('Username', isEqualTo: username)
        .where('Email', isEqualTo: email);

    usernames.snapshots().map((friends) {
      if (friends.docs.isEmpty) {
        getBool = false;
      }
      else {
          getBool = true;
        }
    });
    return getBool;
  }

  Future<void> setNewUser(String username, String email,
      {String referUsername = ""}) async {
    try {
      firestore.collection('CurrentUsers').add({
        'Username': username,
        'Email': email,
        'ReferUsername': referUsername,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser(
      {required String uid, required UserModel userModel}) async {
    try {
      userModel.userId = userModel.userId = firestore
          .collection('BitinMiners')
          .doc(uid)
          .collection('UserData')
          .doc()
          .id;
      firestore
          .collection('BitinMiners')
          .doc(uid)
          .collection('UserData')
          .doc(userModel.userId)
          .set({
        'userId': userModel.userId,
        'userName': userModel.userName,
        'userCoins': userModel.userCoins,
        'userRefers': userModel.userRefers,
        'userCoinMiningRate': userModel.userCoinMiningRate,
        'userIsActive': userModel.userIsActive,
        'clickTime': userModel.clickTime,
        'userIsMining': userModel.userIsMining,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(
      AsyncSnapshot<List<UserModel>> snapshot, int index, String uid) async {
    await firestore
        .collection('BitinMiners')
        .doc(uid)
        .collection('UserData')
        .doc(snapshot.data![index].userId)
        .delete();
  }
}
