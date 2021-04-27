import 'package:GRSON/welcomePages/components/rounded_button.dart';
import 'package:GRSON/welcomePages/components/rounded_input_validation_field.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomePages/Signup/components/background.dart';

class VerifyEmailForPassword extends StatelessWidget {
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
                    "We have sent a verfication code to your email",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Please chick your email",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.01),
                  RoundedInputValidationField(
                    hintText: "Validation Code",
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "Change Password",
                    press: () {
                      Navigator.pushReplacementNamed(context, '/homee');
                      //change this
                    },
                  ),
                ],
              ),
            )));
  }
}
