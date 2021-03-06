import 'package:GRSON/PushNotification/pushNotiReq.dart';
import 'package:GRSON/model/QueupOrder.dart';
import 'package:GRSON/secondPages/customer_screens/Take%20Away/Widgets/ItemDivider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class queueAcceptDetails extends StatefulWidget {
  String docId;

  queueAcceptDetails({this.docId});

  @override
  _queueAcceptDetailsState createState() => _queueAcceptDetailsState();
}

class _queueAcceptDetailsState extends State<queueAcceptDetails> {
  final queUpOrderManager _queUpOrderManager = new queUpOrderManager();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final acceptedQueData = {
    "title": "You are next in line.",
  };
  // final declineTAKData = {
  //   "title": "Sorry!! Your order is decline.",
  // };
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
                              .doc(widget.docId)
                              .collection('orders')
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
                                return StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('restaurant')
                                        .doc(auth.currentUser.uid)
                                        .collection('queues')
                                        .doc(widget.docId)
                                        .collection('orders')
                                        .doc(document.id)
                                        .collection('queueOrders')
                                        .where('status', isEqualTo: 'Waiting')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      String myDoc = document.id;
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListView(
                                          shrinkWrap: true,
                                          reverse: true,
                                          children: snapshot.data.docs
                                              .map((document) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          top: 8,
                                                          bottom: 8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              '/queueAcceptDetails');
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(document[
                                                                'customerName']),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.20,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child: TextButton(
                                                              child: Text(
                                                                  "Accepet"
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14)),
                                                              style:
                                                                  ButtonStyle(
                                                                      padding: MaterialStateProperty.all<
                                                                              EdgeInsets>(
                                                                          EdgeInsets.all(
                                                                              15)),
                                                                      foregroundColor:
                                                                          MaterialStateProperty.all<Color>(Colors
                                                                              .green),
                                                                      shape: MaterialStateProperty.all<
                                                                              RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(18.0),
                                                                      ))),
                                                              onPressed: () {
                                                                _queUpOrderManager.updateOrder(
                                                                    widget
                                                                        .docId,
                                                                    myDoc,
                                                                    document.id,
                                                                    'Accepet');
                                                                getRestaurant(
                                                                    document[
                                                                        'userId'],
                                                                    acceptedQueData);
                                                              }),
                                                        ),

                                                        // Expanded(
                                                        //   flex: 3,
                                                        //   child: TextButton(
                                                        //       child: Text(
                                                        //           "Decline"
                                                        //               .toUpperCase(),
                                                        //           style: TextStyle(
                                                        //               fontSize:
                                                        //               14)),
                                                        //       style:
                                                        //       ButtonStyle(
                                                        //           padding: MaterialStateProperty.all<
                                                        //               EdgeInsets>(
                                                        //               EdgeInsets.all(
                                                        //                   15)),
                                                        //           foregroundColor:
                                                        //           MaterialStateProperty.all<Color>(Colors
                                                        //               .red),
                                                        //           shape: MaterialStateProperty.all<
                                                        //               RoundedRectangleBorder>(
                                                        //               RoundedRectangleBorder(
                                                        //                 borderRadius:
                                                        //                 BorderRadius.circular(18.0),
                                                        //               ))),
                                                        //       onPressed: () {
                                                        //         _queUpOrderManager.updateOrder(
                                                        //             widget
                                                        //                 .docId,
                                                        //             myDoc,
                                                        //             document.id,
                                                        //             'Decline');
                                                        //         getRestaurant(
                                                        //             document[
                                                        //             'userId'],
                                                        //             declineTAKData);
                                                        //       }),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                ItemDivider(),
                                              ],
                                            );
                                          }).toList());
                                    });
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
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "Queue acc");
        },
      ),
      title: Text(
        "Queue details",
      ),
      elevation: 30,
      brightness: Brightness.dark,
    );
  }
}
