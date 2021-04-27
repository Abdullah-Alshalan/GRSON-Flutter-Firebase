import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:flutter/material.dart';

class TKOrderConfirm extends StatefulWidget {
  @override
  _TKOrderConfirmState createState() => _TKOrderConfirmState();
}

class _TKOrderConfirmState extends State<TKOrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        title: Text('Order Confirmed'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.check_circle_outline,
              size: 150,
              color: kPrimaryColor,
            ),
          ),
          Text('Order confirm', style: TextStyle(
            color: kPrimaryColor,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    );
  }
}
