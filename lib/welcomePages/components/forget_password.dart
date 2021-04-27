import 'package:flutter/material.dart';
import 'package:GRSON/welcomepages/constants.dart';


class FirgetPassword extends StatelessWidget {
  final bool login;
  final Function press;
  const FirgetPassword({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          // login ? "Don’t have an Account ? " : "Already have an Account ? ",
          "Forget your password ? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            // login ? "Sign Up" : "Sign In",
            "Change password",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}

