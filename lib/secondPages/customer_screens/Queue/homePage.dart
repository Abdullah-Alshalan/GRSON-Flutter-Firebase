import 'package:GRSON/secondPages/widgets/card-horizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'QueuePage.dart';

class HomeQueuePage extends StatelessWidget {
  String page;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('restaurant')
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
                        child: document != null
                            ? CardHorizontal(
                                url: document['locationUrl'],
                                status: document['Status'],
                                title: document['restaurantName'],
                                img: document['restaurantImage'],
                                tap: () {
                                  if (document['Status'] != "CLOSE") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QueuePage(
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
                                })
                            : Center(
                                child: Text(
                                    'There is not restaurants in Queue Up')));
                  }).toList(),
                );
              }),
        ),
      ],
    );
  }
}
