import 'package:GRSON/secondPages/widgets/card-horizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VHomeTakeAwayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('restaurant').where('takeaway', isEqualTo: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CardHorizontal(
                          title: document['restaurantName'],
                          img: document['restaurantImage'],
                          tap: () {
                            Navigator.pushNamed(context, 'Sign In');
                          }),
                    );
                  }).toList(),
                );
              }),
        ),
      ],
    );
  }
}
