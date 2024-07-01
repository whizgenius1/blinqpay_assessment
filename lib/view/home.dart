import 'package:blinqpay_assesment/states/theme_state.dart';
import 'package:blinqpay_assesment/view/posts_screen.dart';
import 'package:blinqpay_assesment/view/users_screen.dart';
import 'package:blinqpay_assesment/widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> _body = [const UsersScreen(), const PostsScreen()];

List<Map<String, dynamic>> _bottomNavs = [
  {'name': 'Users', 'icon': Icons.person, 'index': 0},
  {'name': 'Posts', 'icon': Icons.video_call, 'index': 1}
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return MainWidget(
      appBar: AppBar(
        title: Text(
          _bottomNavs[index]['name'],
        ),
        actions: [
          Consumer(builder: (_, ref, child) {
            return IconButton(
                onPressed: () {
                  ref.read(darkModeProvider.notifier).toggle();
                },
                icon: Icon(
                  ref.watch(darkModeProvider)
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ));
          })
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
              _bottomNavs.length,
              (index) => Expanded(
                      child: InkWell(
                    onTap: () => setState(() => this.index = index),
                    child: SizedBox(
                      height: 45,
                      child: Consumer(builder: (_, ref, child) {
                        return Column(
                          children: [
                            Icon(
                              _bottomNavs[index]['icon'],
                              color: _bottomNavs[index]['index'] == this.index
                                  ? Colors.blue
                                  : ref.read(darkModeProvider)
                                      ? Colors.grey
                                      : null,
                            ),
                            Text(
                              _bottomNavs[index]['name'],
                              style: TextStyle(
                                  color:
                                      _bottomNavs[index]['index'] == this.index
                                          ? Colors.blue
                                          : ref.read(darkModeProvider)
                                              ? Colors.grey
                                              : null),
                            )
                          ],
                        );
                      }),
                    ),
                  ))),
        ],
      ),
      body: Center(child: _body[index]),
    );
  }
}
