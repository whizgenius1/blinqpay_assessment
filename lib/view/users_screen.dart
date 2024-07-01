import 'package:blinqpay_assesment/model/user_model.dart';
import 'package:blinqpay_assesment/service/user_service.dart';
import 'package:blinqpay_assesment/view/user_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (_, ref, child) => ref.watch(userAsyncProvider).when(
            data: (data) => ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 2,
                    child: Divider(),
                  ),
                  itemBuilder: (_, index) => UserWidget(
                    userModel: data[index],
                    heroTag: '$index',
                  ),
                ),
            error: (_, s) => const SizedBox(),
            loading: () => const CircularProgressIndicator()));
  }
}

class UserWidget extends StatelessWidget {
  final UserModel userModel;
  final String heroTag;
  const UserWidget({super.key, required this.userModel, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: userModel.photo ?? '',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.person_2),
          ),
        ),
        title: Text(userModel.name ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userModel.username ?? ''),
            //    Text(userModel.userId ?? ''),
          ],
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => UserDetailScreen(
                      userModel: userModel,
                      heroTag: heroTag,
                    ))),
      ),
    );
  }
}
