import 'package:flutter/material.dart';
import 'package:projet_flutter/page/loading_page.dart';

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
      home: const LoadingPage(),
    );
  }
}



