import 'package:flutter/material.dart';

class UpperPicture extends StatelessWidget {
  UpperPicture({this.imageLink});
  String imageLink;
  @override
  Widget build(BuildContext context) {
    return Container(
      //picture only
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(
                imageLink,
              // "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
    ),
        ),
      ),
    );
  }
}
