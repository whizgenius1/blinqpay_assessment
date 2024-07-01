import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  const MainWidget(
      {super.key, required this.body, this.bottomNavigationBar, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: body,
      ),
    );
  }
}
