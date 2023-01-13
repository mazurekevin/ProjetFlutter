import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter/page/register_page.dart';

import '../models/login.dart';
import '../service/service_user.dart';
import '../widgets/button_widget.dart';
import '../widgets/header_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Login login = Login(email: "", password: "");


  void _setText()async {
    setState(() {
      login.email = emailController.text;
      login.password = passwordController.text;
    });
    var response = await ServiceUser().login(login);
    if(response?.email==login.email){
      print("good");
      //changer de page => homePage
      //Navigator.push();
    }else{
      print("erreur");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: <Widget>[
          HeaderContainer("Login"),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _textInput(controller:emailController ,hint: "Email", icon: Icons.email),
                  _textInput(controller:passwordController ,hint: "Password", icon: Icons.vpn_key),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "Forgot Password?",
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ButtonWidget(
                        onClick: () {
                          _setText();
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegPage()));*/
                        },
                        btnText: "LOGIN",
                      ),
                    ),
                  ),
                  InkWell(
                    child:RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: "Registor",
                          style: TextStyle(color: Colors.blue),
                        ),

                      ]),

                    ) ,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute<void>(
                              builder:(BuildContext context) {
                                return RegPage();
                              }));
                    },
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    ),
    );
  }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
