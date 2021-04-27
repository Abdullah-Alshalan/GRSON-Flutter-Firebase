import 'package:flutter/material.dart';
import 'package:GRSON/welcomepages/components/text_field_container.dart';
import 'package:GRSON/welcomepages/constants.dart';

class RoundedInputLocationField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputLocationField({
    Key key,
    this.hintText,
    this.initialValue,
    this.icon = Icons.location_pin,
    this.onChanged,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
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
