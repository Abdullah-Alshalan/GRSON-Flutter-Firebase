import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("assets/images_welcomepages/main_top.png",
                width: size.width * 0.3, color: ArgonColors.primary),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/images_welcomepages/main_bottom.png",
                width: size.width * 0.2, color: ArgonColors.primary),
          ),
          child,
        ],
      ),
    );
  }
}