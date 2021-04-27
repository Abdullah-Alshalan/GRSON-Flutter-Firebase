import 'package:GRSON/firebase/authRepository.dart';
import 'package:GRSON/welcomePages/components/rounded_button.dart';
import 'package:GRSON/welcomePages/components/rounded_input_email_field.dart';
import 'package:GRSON/welcomePages/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CEditProfile extends StatefulWidget {
  @override
  _CEditProfileState createState() => _CEditProfileState();
}

class _CEditProfileState extends State<CEditProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthrRepository _auth = new AuthrRepository();
  String password;
  String confirmPassword;
  String displayName;
  bool updated = false;


  Future<void> updateData() async {
    var response = await auth.currentUser
        .updateProfile(displayName: displayName,);
    auth.currentUser.updatePassword(password);
    setState(() {
      updated = true;
    });
    return "Data updated";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/profile');
          },
        ),
        // transparent: true,
      ),
      body: Stack(
        children: [
          ClipPath(
            child: Container(color: Colors.blue),
            clipper: getClipper(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60,),
              Center(
                child: RoundedInputEmailField(
                  initialValue: auth.currentUser.displayName,
                  hintText: "Your Name",
                  onChanged: (value) {
                    setState(() {
                      displayName = value;
                    });
                  },
                ),
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedPasswordField(
                hintText: "Confirm ",
                onChanged: (value) {
                  confirmPassword = value;
                },
              ),
             RoundedButton(
                      text: "Update Profile",
                      press: () {
                        updateData();
                        if (password == confirmPassword) {
                          Navigator.pushReplacementNamed(context, '/Restaurant');
                        }
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 2.0);
    path.lineTo(size.width + 480, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
