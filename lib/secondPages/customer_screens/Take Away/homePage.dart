import 'package:GRSON/secondPages/widgets/card-horizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TakeAwayPage.dart';

class HomeTakeAwayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('restaurant')
                  .where('takeaway', isEqualTo: true)
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
                          status: document['Status'],
                          tap: () {
                            if (document['Status'] != "CLOSE") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TakeAwayPage(
                                        resturantDocId: document.id,
                                        resturantImage:
                                            document['restaurantImage'])),
                              );
                            } else {
                              Get.snackbar("Unfortunately",
                                  "The Restaurants is not closed.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white);
                            }
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
