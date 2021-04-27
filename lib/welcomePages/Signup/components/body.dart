import 'package:GRSON/firebase/authRepository.dart';
import 'package:GRSON/firebase/resturent.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/components/enum.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomepages/Signup/components/background.dart';
import 'package:GRSON/welcomepages/components/already_have_account.dart';
import 'package:GRSON/welcomepages/components/rounded_button.dart';
import 'package:GRSON/welcomepages/components/rounded_input_email_field.dart';
import 'package:GRSON/welcomepages/components/rounded_input_person_field.dart';
import 'package:GRSON/welcomepages/components/rounded_password_field.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<Body> {
  final AuthrRepository _auth = new AuthrRepository();
  final Restaurant _restaurant = new Restaurant();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String _email = '';
  String _password = '';
  String _userName = '';
  String _token;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseMessaging.getToken().then((token){
      setState(() {
        _token = token;
      });
    });
  }



  SingingCharacter temp = SingingCharacter.customer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      page: 'WelcomePage', //this is for back button
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
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
            RoundedInputPersonField(
              hintText: "Your Username",
              onChanged: (value) {
                setState(() {
                  _userName = value;
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
            // RoundedConfirmPasswordField(
            //   onChanged: (value) {},
            // ),
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
              text: "SIGN UP",
              press: () {
                signUp(context);
              },
            ),
            SizedBox(height: size.height * 0.02),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacementNamed(context, 'Sign In');
              },
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
    );
  }

  signUp(context) async {
    try {
      String isSignnedUp = await _auth.signUp(_email, _password, _userName);
      await _auth.saveUser(temp.toString(), _token);

      if (isSignnedUp == "user signUp") {
        if(temp == SingingCharacter.customer){
          Navigator.pushReplacementNamed(context, '/home');
          Get.snackbar(
            "Congratulation",
            "You have successfully! Signed Up as Customer",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ArgonColors.primary,
            colorText: Colors.white,
          );
        }
        else{
          await _restaurant.createRestaurant();
          Navigator.pushReplacementNamed(context, "Restaurant");
          Get.snackbar(
            "Congratulation",
            "You have successfully! Signed Up as Restaurant",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ArgonColors.primary,
            colorText: Colors.white,
          );
        }
      }
      else
        print("problem");
    } on PlatformException catch (e) {
    }
  }
}
