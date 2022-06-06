import 'package:flutter/material.dart';
import 'package:flutter_master_chat_app/components/custome_material_button.dart';
import 'package:flutter_master_chat_app/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: Container(
                height: 200.0,
                child: Image.asset('images/master_chat_icon.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kFormFieldsInputDecoration.copyWith(
                  hintText: "Enter Your Email"),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscuringCharacter: '#',
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kFormFieldsInputDecoration.copyWith(
                  hintText: "Enter Your Password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            CustomMaterialButton(
              buttonText: "Login",
              buttonColor: Colors.lightBlueAccent,
              onPressed: () {
                //Implement login functionality.
              },
            ),
          ],
        ),
      ),
    );
  }
}
