import 'dart:async';

import 'package:blinqpay_assesment/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAsyncProvider =
    AsyncNotifierProvider<UserServiceAsyncNotifier, List<UserModel>>(
        () => UserServiceAsyncNotifier());

class UserServiceAsyncNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  FutureOr<List<UserModel>> build() => _getUserData();

  Future<List<UserModel>> _getUserData() async =>
      await FirebaseFirestore.instance.collection('users').get().then((value) =>
          value.docs
              .map((doc) => doc.data())
              .toList()
              .map((e) => UserModel.fromJson(e))
              .toList());

  ///samething as the one on top, but more understandable
  //   final usersSnapshot =
  //       await FirebaseFirestore.instance.collection('users').get();

  //   List<Map<String, dynamic>> users =
  //       usersSnapshot.docs.map((doc) => doc.data()).toList();
  //   List<UserModel> usersModel =
  //       users.map((e) => UserModel.fromJson(e)).toList();
  //   return usersModel;

  Future<void> reloadUserData() async =>
      state = await AsyncValue.guard(() => _getUserData());
}
