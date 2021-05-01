import 'package:GRSON/PushNotification/pushNotiReq.dart';
import 'package:GRSON/model/TakeAwayOrder.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TakeAwayAcceptDetails extends StatefulWidget {
  TakeAwayAcceptDetails({this.firstDocId});
  String firstDocId;
  @override
  _TakeAwayAcceptDetailsState createState() => _TakeAwayAcceptDetailsState();
}

class _TakeAwayAcceptDetailsState extends State<TakeAwayAcceptDetails> {
  final OrderManager _orderManager = new OrderManager();
  final acceptedTAKData = {
    "title": "Hurray!! Your order is  Accepted.",
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
                      .doc(widget.firstDocId)
                      .collection('products')
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
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            document['itemImage'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(document['itemName'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            document['itemPrice'] + ' SAR',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          SizedBox(
                                            height: 18,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      left: 6, right: 6),
                                                  child: Text(
                                                    document['quantity'].toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold),
                                                  )),

                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "Take Away acc");
        },
      ),
      title: Text(
        "Take away Details",
      ),
      elevation: 30,
      brightness: Brightness.dark,
    );
  }

}
