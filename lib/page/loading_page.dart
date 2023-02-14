import 'dart:async';

import 'package:flutter/material.dart';

import 'login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    const blue = Color(0xff033976);
    const purple = Color(0xff6d07c5);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            blue,
            purple,
          ],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter
          ),
        ),
        child: Center(
          child: Image.asset(
            '/FluFlix2Big.png',
          ),
        ),
      ),
    );
  }
}
