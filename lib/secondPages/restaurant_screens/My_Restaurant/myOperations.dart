import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Operations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 14.0, right: 14.0, top: MediaQuery.of(context).size.height / 5),
      child: Column(
        children: [
          accept_take_away(context),
          Divider(
            color: ArgonColors.muted,
            height: 50,
            thickness: 0.5,
            indent: 40,
            endIndent: 40,
          ),
          accept_queue(context),
        ],
      ),
    );
  }

  RoundedButton accept_queue(BuildContext context) {
    return RoundedButton(
      text: "Accept Queue Order",
      press: () {
        Navigator.pushReplacementNamed(context, "Queue acc");
      },
    );
  }

  RoundedButton accept_take_away(BuildContext context) {
    return RoundedButton(
      text: "Accept Take Away Order",
      press: () {
        Navigator.pushReplacementNamed(context, "Take Away acc");
      },
    );
  }
}
