import 'package:GRSON/firebase/authRepository.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/components/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomepages/signin/components/background.dart';
import 'package:GRSON/welcomepages/components/already_have_account.dart';
import 'package:GRSON/welcomepages/components/rounded_button.dart';
import 'package:GRSON/welcomepages/components/rounded_input_email_field.dart';
import 'package:GRSON/welcomepages/components/rounded_password_field.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<Body> {
  String _email = '';
  String _password = '';
  SingingCharacter temp = SingingCharacter.customer;
  final AuthrRepository _auth = new AuthrRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      page: 'WelcomePage',
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN IN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
            ),
            SizedBox(height: size.height * 0.05),
            RoundedInputEmailField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            Divider(
              color: ArgonColors.muted,
              height: 10,
              thickness: 0.5,
              indent: 40,
              endIndent: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Radio(
                activeColor: kPrimaryColor,
                value: SingingCharacter.customer,
                groupValue: temp,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    temp = value;
                  });
                },
              ),
              Text(
                'Customer',
                style: TextStyle(fontSize: 20),
              ),
              Radio(
                activeColor: kPrimaryColor,
                value: SingingCharacter.restaurant,
                groupValue: temp,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    temp = value;
                  });
                },
              ),
              Text(
                'Restaurant',
                style: TextStyle(fontSize: 20),
              ),
            ]),
            RoundedButton(
              text: "SIGN IN",
              press: () {
                signIn(context);
              },
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(height: size.height * 0.01),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacementNamed(context, 'Sign Up');
              },
            ),
          ],
        ),
      ),
    );
  }

  signIn(context) async {
    try {
      // getUser
      String login = await _auth.signIn(_email, _password);
      String roleCheck = await _auth.getUser();
      print("roleCheck");
      print(roleCheck);
      final token = print(roleCheck);
      if (login == "Signed In" &&
          roleCheck == temp.toString() &&
          roleCheck == "SingingCharacter.customer") {
        Navigator.pushReplacementNamed(context, '/home');
      }
      if (login == "Signed In" && roleCheck != temp.toString()) {
        Get.snackbar(
          "Error!!",
          "The User Does not exist, Please recheck.",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
      if (login == "Signed In" &&
          roleCheck == temp.toString() &&
          roleCheck == "SingingCharacter.restaurant") {
        Navigator.pushReplacementNamed(context, "Restaurant");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error!!",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
