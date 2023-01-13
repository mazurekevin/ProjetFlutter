import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../service/service_user.dart';
import '../widgets/button_widget.dart';
import '../widgets/header_container.dart';
import 'login_page.dart';


class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}


class _RegPageState extends State<RegPage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _setText() async {
    var response = await ServiceUser().createUser(firstnameController.text,lastnameController.text,emailController.text,passwordController.text);
    if(response == 201){
      Navigator.push(context,
          MaterialPageRoute<void>(
              builder:(BuildContext context) {
                return LoginPage();
              }));
    }else{
      print("erreur");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),

        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(controller:firstnameController ,hint: "Firstname", icon: Icons.person),
                    _textInput(controller:lastnameController ,hint: "Lastname", icon: Icons.person),
                    _textInput(controller:emailController,hint: "Email", icon: Icons.email),
                    _textInput(controller:passwordController,hint: "Password", icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTER",
                          onClick: (){
                            _setText();
                            //print("object");
                            //Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      child:RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Already a member ? ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.blue)),
                        ]),
                      ) ,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder:(BuildContext context) {
                                  return LoginPage();
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
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