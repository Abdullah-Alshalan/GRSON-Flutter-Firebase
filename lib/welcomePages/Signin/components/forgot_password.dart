import 'package:GRSON/welcomePages/components/rounded_button.dart';
import 'package:GRSON/welcomePages/components/rounded_input_email_field.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomePages/Signin/components/background.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
            page: 'Sign In', //this is for the back button
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Please enter your email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  SizedBox(height: size.height * 0.01),
                  RoundedInputEmailField(
                    hintText: "Your Email",
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "Send Code",
                    press: () {
                      Navigator.pushReplacementNamed(context, 'passValidation');
                    },
                  ),
                ],
              ),
            )));
  }
}
