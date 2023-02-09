import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  final String text;
  final double height;

  const HeaderContainer({
    Key? key,
    required this.text,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xff033976);
    const purple = Color(0xff6d07c5);
    return Container(
      height: MediaQuery.of(context).size.height * height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            blue,
            purple,
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Image.asset(
              '/FluFlix2.png',
            ),
          ),
        ],
      ),
    );
  }
}
