import 'package:GRSON/PushNotification/pushNotiReq.dart';
import 'package:GRSON/model/TakeAwayOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'TakeAwayAcceptDetails.dart';

class TakeAwayAccepet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<TakeAwayAccepet> {
  final OrderManager _orderManager = new OrderManager();
  final acceptedTAKData = {
    "title": "Your order is Accepted.",
  };
  final declineTAKData = {
    "title": "Sorry, Your order is declined.",
  };

  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
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
                              .collection('takeAwayOrders')
                              .where('status', isEqualTo: 'Waiting')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              reverse: true,
                              children: snapshot.data.docs.map((document) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TakeAwayAcceptDetails(
                                                  firstDocId: document.id,
                                                )),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(document['customerName']),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.20,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: TextButton(
                                              child: Text(
                                                  "Accepet Next".toUpperCase(),
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.all(15)),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.green),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ))),
                                              onPressed: () {
                                                print(document.id);
                                                _orderManager.updateOrder(
                                                    auth.currentUser.uid,
                                                    document.id,
                                                    'Accepet');
                                                getRestaurant(
                                                    document['userId'],
                                                    acceptedTAKData);
                                              }),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: TextButton(
                                              child: Text(
                                                  "Decline".toUpperCase(),
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              style: ButtonStyle(
                                                  padding: MaterialStateProperty
                                                      .all<EdgeInsets>(
                                                          EdgeInsets.all(15)),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.red),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ))),
                                              onPressed: () {
                                                print(document.id);
                                                _orderManager.updateOrder(
                                                    auth.currentUser.uid,
                                                    document.id,
                                                    'Decline');
                                                getRestaurant(
                                                    document['userId'],
                                                    declineTAKData);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          })
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
        "Take away",
      ),
      elevation: 30,
      brightness: Brightness.dark,
    );
  }
}
