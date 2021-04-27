import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/welcomepages/signin/components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      body: Body(),
    );
  }
}
