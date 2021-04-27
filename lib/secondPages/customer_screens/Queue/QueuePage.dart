import 'package:GRSON/model/QueupOrder.dart';
import 'package:GRSON/secondPages/customer_screens/Take%20Away/Widgets/ItemDivider.dart';
import 'package:GRSON/secondPages/customer_screens/Take%20Away/Widgets/UpperPicture.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../QueueOrderConfirm.dart';

class QueuePage extends StatefulWidget {
  QueuePage({this.resturantDocId, this.resturantImage});

  final String resturantDocId;
  final String resturantImage;

  @override
  _QueuePage createState() => _QueuePage();
}

class _QueuePage extends State<QueuePage> {
  String valueChoose, valueChoose2;
  final queUpOrderManager _queUpOrderManager = new queUpOrderManager();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ArgonColors.bgColorScreen,
        body: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Container(
                child: Column(
              children: [
                UpperPicture(
                  imageLink: widget.resturantImage,
                ),
                SizedBox(height: size.height * 0.03), //space beetwen them
                Container(
                  width: size.width * 0.98,
                  child: Card(
                      elevation: 9,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('restaurant')
                              .doc(widget.resturantDocId)
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
                                    // color: kPrimaryLightColor,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 8, bottom: 15),
                                    child: InkWell(
                                        onTap: () {
                                          // Navigator.pushReplacementNamed(context, '/home');
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    document['queuesName'],
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextButton(
                                                      child: Text(
                                                          "Queue up".toUpperCase(),
                                                          style:
                                                          TextStyle(
                                                              fontSize: 20)),
                                                      style: ButtonStyle(
                                                          padding:
                                                          MaterialStateProperty.all<EdgeInsets>(
                                                              EdgeInsets.all(10)),
                                                          foregroundColor:
                                                          MaterialStateProperty.all<Color>(
                                                              Colors.green),
                                                          backgroundColor: MaterialStateProperty.all<Color>(
                                                              Colors.lightGreen[50]),
                                                          shape: MaterialStateProperty
                                                              .all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    80.0),
                                                              ))),
                                                      onPressed: () async {
                                                        String orderCheck =
                                                        await _queUpOrderManager
                                                            .createQUOrder(
                                                            widget.resturantDocId, document.id);
                                                        if (orderCheck ==
                                                            "Order is Placed") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    QUOrderConfirm()),
                                                          );
                                                          // }
                                                        }
                                                      }
                                                  ),
                                                ),
                                              ],
                                            ),

                                            ItemDivider(),
                                          ],
                                        )));
                              }).toList(),
                            );
                          })),
                )
              ],
            )),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 55,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
              width: size.width * 0.25,
              height: size.width * 0.40,
            ),
          ]),
        ));
  }
}
