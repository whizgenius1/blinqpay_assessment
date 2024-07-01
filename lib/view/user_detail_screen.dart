import 'package:blinqpay_assesment/model/post_model.dart';
import 'package:blinqpay_assesment/model/user_model.dart';
import 'package:blinqpay_assesment/service/post_service.dart';
import 'package:blinqpay_assesment/view/posts_screen.dart';
import 'package:blinqpay_assesment/widgets/main_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel userModel;
  final String heroTag;
  const UserDetailScreen(
      {super.key, required this.userModel, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, child) {
      List<PostModel> postModel = ref.watch(postAsyncProvider).asData!.value;
      List<PostModel> newPostModel = [];
      for (PostModel p in postModel) {
        if (p.username == userModel.username) {
          newPostModel.add(p);
        }
      }
      return MainWidget(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Hero(
                        tag: heroTag,
                        child: CachedNetworkImage(
                          imageUrl: userModel.photo ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person_2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userModel.name ?? ''),
                        Text(userModel.username ?? ''),
                        Text(userModel.bio ?? '')
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: newPostModel.isEmpty
                      ? const Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.hourglass_empty),
                            SizedBox(
                              height: 10,
                            ),
                            Text('No Post'),
                          ],
                        ))
                      : GridView.builder(
                          itemCount: newPostModel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemBuilder: (_, index) => GridViewWidget(
                                postModel: newPostModel[index],
                              ))),
              //  Text('${newPostModel.length}')
            ],
          ),
        ),
      );
    });
  }
}

class GridViewWidget extends StatelessWidget {
  final PostModel postModel;
  const GridViewWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => Dialog(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 50,
                    child: PostWidget(
                      postModel: postModel,
                      shouldNavigate: false,
                    ),
                    // child: postModel.noMedia == false &&
                    //         postModel.video == false
                    //     ? CachedNetworkImage(
                    //         fit: BoxFit.cover,
                    //         imageUrl: postModel.link ?? '',
                    //         placeholder: (context, url) =>
                    //             const CircularProgressIndicator(),
                    //         errorWidget: (context, url, error) =>
                    //             const Icon(Icons.person_2),
                    //       )
                    //     : postModel.noMedia == false && postModel.video == true
                    //         ? VideoPlayerWidget(
                    //             videoLink: postModel.link ?? '',
                    //           )
                    //         : Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 5),
                    //             child: Center(
                    //                 child: Text(
                    //               postModel.description ?? '',
                    //               textAlign: TextAlign.center,
                    //             )),
                    //           ),
                  ),
                ));
      },
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: postModel.thumbnail ?? '',
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.image),
      ),
    );
  }
}
