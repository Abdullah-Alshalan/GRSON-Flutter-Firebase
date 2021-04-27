import 'package:GRSON/firebase/resturent.dart';
import 'package:GRSON/secondPages/customer_screens/Take%20Away/Widgets/ItemDivider.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResQueue extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Restaurant _restaurant = new Restaurant();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('restaurant')
            .doc(auth.currentUser.uid)
            .collection('queues')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                color: ArgonColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(document['queuesName']),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                              child: Text("Delete".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                              style: ButtonStyle(
                                  padding:
                                  MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(15)),
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      ArgonColors.error),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            18.0),
                                      ))),
                              onPressed: ()  {
                              _restaurant.deteleQueues(document.id);

                          }),
                        ),
                      ],
                    ),
                    ItemDivider(),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
