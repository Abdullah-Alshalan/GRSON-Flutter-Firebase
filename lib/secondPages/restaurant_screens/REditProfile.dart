import 'dart:io';
import 'package:GRSON/firebase/authRepository.dart';
import 'package:GRSON/welcomePages/components/rounded_button.dart';
import 'package:GRSON/welcomePages/components/rounded_password_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class REditProfile extends StatefulWidget {
  @override
  _REditProfileState createState() => _REditProfileState();
}

class _REditProfileState extends State<REditProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthrRepository _auth = new AuthrRepository();
  String password;
  String confirmPassword;
  String displayName;
  String profilePicture;
  File imageFile = null;
  final picker = ImagePicker();
  String filePath;
  String filename = DateTime.now().toString();
  bool updated = false;
  String getResturantImages;

  Future getResturantImage() async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentSnapshot myRestaurant = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(_auth.currentUser.uid)
          .get();
      final restaurantImage = myRestaurant.data()['restaurantImage'];
      setState(() {
        getResturantImages = restaurantImage;
      });
      return restaurantImage;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResturantImage();
  }

  Future updateData() async {
    _auth.updateUser(displayName, password);
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
            Navigator.pushReplacementNamed(context, 'Restaurant');
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
              Center(
                child: getResturantImages == null
                    ? CircularProgressIndicator()
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(getResturantImages),
                      ),
              ),
              // RoundedInputPersonField(
              //   initialValue: auth.currentUser.displayName,
              //   hintText: "Your Name",
              //   onChanged: (value) {
              //     setState(() {
              //       displayName = value;
              //     });
              //   },
              // ),
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
                press: () async {
                  updateData();
                  if (password == confirmPassword && updated == true) {
                    Navigator.pushReplacementNamed(context, '/Restaurant');
                  }
                },
              )
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
