// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/views/components/app_text.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutterfirebase/views/components/container.dart';
import 'package:flutterfirebase/views/components/image_container.dart';
import 'package:flutterfirebase/views/components/password_textfield.dart';
import 'package:flutterfirebase/views/components/username_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //signInUSER
  void signInUser() async {
    //loading circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });

    //sign In
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == "user-not-found") {
        wrongEmail();
      }
      if (e.code == "wrong-password") {
        wrongPassword();
      }
    }
  }

  void wrongEmail() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Wrong Email",
            ),
            content: Text("No user found for that email."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        });
  }

  void wrongPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Wrong Password",
            ),
            content: Text("Incorrect password provided."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Spacer(),
                Icon(
                  Icons.lock,
                  size: 60,
                ),
                Text("Welcome", style: AppText.mainText),
                Spacer(),
                UsernameTextField(
                  label: ("Email address"),
                  controller: emailController,
                  hinttext: "peter@gmail.com",
                  obscuretext: false,
                ),
                SizedBox(
                  height: 12,
                ),
                PasswordTextfield(
                  label: ("Password"),
                  controller: passwordController,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgot');
                      },
                      child: Text("forgot password?", style: AppText.subText),
                    )),
                SizedBox(
                  height: 24,
                ),
                ContainerBox(
                  onTap: signInUser,
                  hintText: 'Sign In',
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Or continue with", style: AppText.bodyText),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade300,
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child:
                            ImageContainer(imagePath: "assets/png/google.png")),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        child: ImageContainer(
                            imagePath: "assets/png/facebook.png")),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("New Member?", style: AppText.bodyText),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: Text("Register", style: AppText.subText),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
