import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/firebase_options.dart';
import 'package:flutterfirebase/pages/auth_page.dart';
import 'package:flutterfirebase/pages/chat_screen.dart';
import 'package:flutterfirebase/pages/forgot.dart';
import 'package:flutterfirebase/pages/login_page.dart';
import 'package:flutterfirebase/pages/signup_screen.dart';

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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const AuthPage(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => SignupScreen(),
          '/forgot': (context) => ForgotPassowrd(),
          '/chatscreen': (context) => const ChatScreen(),
        });
  }
}
