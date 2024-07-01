import 'dart:async';

import 'package:blinqpay_assesment/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postAsyncProvider =
    AsyncNotifierProvider<PostServiceAsyncNotifier, List<PostModel>>(
        () => PostServiceAsyncNotifier());

class PostServiceAsyncNotifier extends AsyncNotifier<List<PostModel>> {
  @override
  FutureOr<List<PostModel>> build() => _getPostData();

  Future<List<PostModel>> _getPostData() async =>
      await FirebaseFirestore.instance.collection('post').get().then((value) =>
          value.docs
              .map((e) => e.data())
              .toList()
              .map((e) => PostModel.fromJson(e))
              .toList());

  ///samething as the one on top, but more understandable
  // final postsSnapshot =
  //     await FirebaseFirestore.instance.collection('post').get();

  // List<Map<String, dynamic>> posts =
  //     postsSnapshot.docs.map((doc) => doc.data()).toList();
  // log('p:${json.encode(posts)}');
  // List<PostModel> postsModel = [];

  // postsModel = posts.map((e) => PostModel.fromJson(e)).toList();

  // return postsModel;

  Future<void> reloadUserData() async =>
      state = await AsyncValue.guard(() => _getPostData());
}
