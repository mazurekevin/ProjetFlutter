import 'package:flutter/material.dart';
import 'package:projet_flutter/page/home_page.dart';
import 'package:projet_flutter/page/loading_page.dart';
import 'package:projet_flutter/page/navigation_page.dart';
import 'package:projet_flutter/page/profile_page.dart';
import 'package:projet_flutter/page/login_page.dart';

import 'page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Projet',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffe6e6e5),
      ),
      home: NavigationPage(),
    );
  }
}



