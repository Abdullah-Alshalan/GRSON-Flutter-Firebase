import 'package:flutter/material.dart';
import 'package:GRSON/welcomepages/components/text_field_container.dart';
import 'package:GRSON/welcomepages/constants.dart';

class RoundedPriceField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedPriceField({
    Key key,
    this.hintText,
    this.icon = Icons.attach_money,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
