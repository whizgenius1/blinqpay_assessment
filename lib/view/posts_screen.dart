import 'package:blinqpay_assesment/model/post_model.dart';
import 'package:blinqpay_assesment/model/user_model.dart';
import 'package:blinqpay_assesment/service/post_service.dart';
import 'package:blinqpay_assesment/service/user_service.dart';
import 'package:blinqpay_assesment/view/user_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (_, ref, child) => ref.watch(postAsyncProvider).when(
            data: (data) => ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 2,
                    child: Divider(),
                  ),
                  itemBuilder: (_, index) => PostWidget(
                    postModel: data[index],
                  ),
                ),
            error: (_, s) => const SizedBox(),
            loading: () => const CircularProgressIndicator()));
  }
}

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  final bool shouldNavigate;
  const PostWidget(
      {super.key, required this.postModel, this.shouldNavigate = true});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      List<UserModel> usersModel = ref.watch(userAsyncProvider).asData!.value;
      UserModel? userModelData;
      for (UserModel userModel in usersModel) {
        if (postModel.username == userModel.username) {
          userModelData = userModel;
        }
      }
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 160,
          child: Column(
            children: [
              InkWell(
                onTap: () => shouldNavigate
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UserDetailScreen(
                                  userModel: userModelData!,
                                  heroTag: 'heroTag',
                                )))
                    : null,
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CachedNetworkImage(
                        imageUrl: postModel.thumbnail ?? '',
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(postModel.username ?? '')
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: postModel.noMedia == false && postModel.video == false
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: postModel.link ?? '',
                          placeholder: (context, url) =>
                              Image.asset('assets/loading.gif'),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.person_2),
                        )
                      : postModel.noMedia == false && postModel.video == true
                          ? VideoPlayerWidget(
                              videoLink: postModel.link ?? '',
                            )
                          : Center(child: Text(postModel.description ?? ''))),
              const SizedBox(
                height: 5,
              ),
              postModel.noMedia
                  ? const SizedBox()
                  : Text(postModel.description ?? '')
            ],
          ),
        ),
      );
    });
  }
}

class VideoPlayerWidget extends ConsumerStatefulWidget {
  final String videoLink;

  const VideoPlayerWidget({super.key, required this.videoLink});

  @override
  ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  late CachedVideoPlayerController controller;

  late Future<void> _video;
  @override
  void initState() {
    super.initState();

    controller = CachedVideoPlayerController.network(
        Uri.parse(widget.videoLink).toString());
    controller.initialize().then((value) {
      controller.play();
      setState(() {});
    });

    _video = controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _video,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            controller.play();
            return VisibilityDetector(
              key: ObjectKey(controller),
              onVisibilityChanged: (visibility) {
                if (visibility.visibleFraction < 0.5 && mounted) {
                  controller.pause(); //pausing  functionality
                } else {
                  controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CachedVideoPlayer(controller),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
