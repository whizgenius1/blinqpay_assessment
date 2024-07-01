import 'dart:io';

import 'package:blinqpay_assesment/states/theme_state.dart';
import 'package:blinqpay_assesment/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: (Platform.isIOS)
        ? FirebaseOptions(
            iosClientId: dotenv.env['IOS_CLIENT_ID'] ?? '',
            iosBundleId: dotenv.env['IOS_BUNDLE_ID'] ?? '',
            apiKey: dotenv.env['IOS_API_KEY'] ?? '',
            appId: dotenv.env['APP_ID'] ?? '',
            messagingSenderId: '',
            projectId: dotenv.env['PROJECT_ID'] ?? '',
            storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
          )
        : FirebaseOptions(
            apiKey: dotenv.env['ANDROID_API_KEY'] ?? '',
            appId: dotenv.env['APP_ID'] ?? '',
            messagingSenderId: '',
            projectId: dotenv.env['PROJECT_ID'] ?? '',
            storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
          ),
  );

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
