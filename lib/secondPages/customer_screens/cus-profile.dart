import 'package:GRSON/secondPages/widgets/cus-drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/secondpages/theme/Theme.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  // final UserDetails detailsUser;
  // ProfilePage({Key key, this.detailsUser}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Profile"),
        // transparent: true,
      ),
      drawer: CusDrawer(currentPage: "Profile"),
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.blue),
            clipper: getClipper(),
          ),
          Positioned(
            width: 375.0,
            top: MediaQuery
                .of(context)
                .size
                .height / 2.5,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                SizedBox(height: 15.0),
            Text(
              auth.currentUser.displayName,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              auth.currentUser.email,
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: 40.0,
              width: 250.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: ArgonColors.white,
                color: ArgonColors.white,
                elevation: 7.0,
                child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pushReplacementNamed(
                          '/editprofile');
                    },
                child: Center(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          // Container(
          //   height: 40.0,
          //   width: 250.0,
          //   child: Material(
          //     borderRadius: BorderRadius.circular(20.0),
          //     shadowColor: ArgonColors.white,
          //     color: ArgonColors.white,
          //     elevation: 7.0,
          //     child: GestureDetector(
          //       onTap: () {
          //         // _googleSignIn.signOut();
          //         // print('User Signed Out');
          //         // Navigator.of(context).pop();
          //         // FirebaseAuth.instance.signOut().then((value) {
          //         //   Navigator.of(context)
          //         //       .pushReplacementNamed('/landingpage');
          //         // }).catchError((e) {
          //         //   print(e);
          //         // });
          //       },
          //       child: Center(
          //           child: Text(
          //         'Log Out',
          //         style: TextStyle(
          //             color: Colors.black87,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20),
          //       )),
          //     ),
          //   ),
          // )
        ],
      ),
    )],
    )
    ,
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
