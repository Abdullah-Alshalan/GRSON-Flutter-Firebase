import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String page;
  Background({
    Key key,
    @required this.child,
    this.page = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/images_welcomepages/signup_top.png",
                width: size.width * 0.35, color: Colors.blue[200]),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 55),
              onPressed: () {
                Navigator.pushReplacementNamed(context, page);
              },
            ),
            width: size.width * 0.25,
            height: size.width * 0.40,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images_welcomepages/login_bottom.png",
                width: size.width * 0.5, color: Colors.blue[100]),
          ),
          child,
        ],
      ),
    );
  }
}
