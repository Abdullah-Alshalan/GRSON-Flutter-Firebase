import 'package:GRSON/PushNotification/pushNotiReq.dart';
import 'package:GRSON/model/QueupOrder.dart';
import 'package:GRSON/secondPages/customer_screens/Take%20Away/Widgets/ItemDivider.dart';
import 'package:GRSON/secondPages/restaurant_screens/My_Restaurant/Operation_pages/queueAcceptDetails.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QueueAccepet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<QueueAccepet> {
  final queUpOrderManager _queUpOrderManager = new queUpOrderManager();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final acceptedQueData = {
      "title": "Hurray!! Your order is  Accepted.",
  };
  final declineQueData = {
    "title": "Unfortunately!! Your order has been Declined.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 24.0, right: 24.0, bottom: 32),
              child: Card(
                  elevation: 9,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('restaurant')
                              .doc(auth.currentUser.uid)
                              .collection('queues')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Column(
                              children: snapshot.data.docs.map((document) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'queueAcceptDetails');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                queueAcceptDetails(docId: document.id)),
                                      );
                                    },

                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(document['queuesName']),
                                        ),
                                        ItemDivider(),
                                        // TextButton(
                                        //     child: Text(
                                        //         "Accepet ".toUpperCase(),
                                        //         style: TextStyle(fontSize: 14)),
                                        //     style: ButtonStyle(
                                        //         padding: MaterialStateProperty
                                        //             .all<EdgeInsets>(
                                        //             EdgeInsets.all(15)),
                                        //         foregroundColor:
                                        //         MaterialStateProperty.all<
                                        //             Color>(Colors.green),
                                        //         shape: MaterialStateProperty.all<
                                        //             RoundedRectangleBorder>(
                                        //             RoundedRectangleBorder(
                                        //               borderRadius:
                                        //               BorderRadius.circular(
                                        //                   18.0),
                                        //             ))),
                                        //     onPressed: () {
                                        //       // _queUpOrderManager.updateOrder(firstDocId, document.id ,'Accepet');
                                        //       // getRestaurant(document['userId'], acceptedQueData);
                                        //     }),
                                        // TextButton(
                                        //     child: Text(
                                        //         "Decline ".toUpperCase(),
                                        //         style: TextStyle(fontSize: 14)),
                                        //     style: ButtonStyle(
                                        //         padding: MaterialStateProperty
                                        //             .all<EdgeInsets>(
                                        //             EdgeInsets.all(15)),
                                        //         foregroundColor:
                                        //         MaterialStateProperty.all<
                                        //             Color>(
                                        //             ArgonColors.error),
                                        //         shape: MaterialStateProperty.all<
                                        //             RoundedRectangleBorder>(
                                        //             RoundedRectangleBorder(
                                        //               borderRadius:
                                        //               BorderRadius.circular(
                                        //                   18.0),
                                        //             ))),
                                        //     onPressed: () {
                                        //       // _queUpOrderManager.updateOrder(firstDocId, document.id ,
                                        //       //     'Decline');
                                        //       // getRestaurant(document['userId'], declineQueData);
                                        //     }),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),

                    ],
                  )),
            ),
          ]),
        ));
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, size: 25),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "Restaurant");
        },
      ),
      title: Text(
        "Queue",
      ),
      elevation: 30,
      brightness: Brightness.dark,
    );
  }

}

