import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomePages/Welcome/components/body.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ArgonColors.bgColorScreen,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Body(),
        ));
  }
}
