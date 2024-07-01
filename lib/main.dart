import 'dart:io';

import 'package:blinqpay_assesment/states/theme_state.dart';
import 'package:blinqpay_assesment/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCVATVkgxyMyy8mnQvf0_rSHbwnO2d4iCg',
      appId: 'com.blinqpay.blinqpost',
      messagingSenderId: '',
      projectId: 'blinqpost',
      storageBucket: 'blinqpost.appspot.com',
    ));
  }

  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyBDNzmaHZYiPrTfV7Y6yQ40IsX_t-iwWYA',
      appId: 'com.blinqpay.blinqpost',
      messagingSenderId: '',
      projectId: 'blinqpost',
      storageBucket: 'blinqpost.appspot.com',
    ));
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ref.watch(darkModeProvider) ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
