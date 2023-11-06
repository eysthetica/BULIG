import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_4/features/app/splash_screen/splash_screen.dart';
import 'package:test_4/features/user_auth/presentation/pages/home_page.dart';
import 'package:test_4/features/user_auth/presentation/pages/login_page.dart';
import 'package:test_4/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      home: SplashSreen(
        child: LoginPage(),
      ),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}
