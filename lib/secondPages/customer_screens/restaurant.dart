import 'package:GRSON/secondPages/widgets/card-horizontal.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class RestaurantItem extends StatelessWidget {
  final String page;
  RestaurantItem({
    Key key,
    this.page = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CardHorizontal(
          // cta: "View restaurant",
          title: homeCards["Ice Cream"]['title'],
          img: homeCards["Ice Cream"]['image'],
          tap: () {
            Navigator.pushNamed(context, page);
          }),
    );
  }
}
