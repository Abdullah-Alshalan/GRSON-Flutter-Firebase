import 'package:GRSON/model/TakeAwayCart.dart';
import 'package:GRSON/secondPages/customer_screens/TakeAwayCart/cart_screen.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Widgets/CheckOutCard.dart';
import 'Widgets/Item.dart';
import 'Widgets/ItemDivider.dart';
import 'Widgets/UpperPicture.dart';

class TakeAwayPage extends StatefulWidget {
  TakeAwayPage({this.resturantDocId, this.resturantImage});
  final String resturantDocId;
  final String resturantImage;
  @override
  _TakeAwayPage createState() => _TakeAwayPage();
}

class _TakeAwayPage extends State<TakeAwayPage> {
  final CartManager _cartManager = new CartManager();

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
                SizedBox(height: size.height * 0.02),
                Container(
                  width: size.width * 0.92,
                  child: Card(
                      elevation: 3,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('restaurant')
                                  .doc(widget.resturantDocId)
                                  .collection('takeaway')
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
                                    return Column(
                                      children: [
                                        Row(children: [
                                          //picture only
                                          Container(
                                            height: 60,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                // fit: BoxFit.fitWidth,
                                                image: NetworkImage(
                                                  document['itemImage'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Name of item
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              document['itemName'],
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              document['itemPrice'] + " SAR",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextButton(
                                                child: Text(
                                                    "Order ".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.green),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      // side:
                                                      //     BorderSide(color: Colors.black)
                                                    ))),
                                                onPressed: () {
                                                  _cartManager.AddCart(
                                                    document['itemName'],
                                                    document['itemPrice'],
                                                    document['itemImage'],
                                                    document.id,
                                                    widget.resturantDocId,
                                                  );
                                                  Get.snackbar(
                                                    "Congratulation",
                                                    "Successfully!! Added in shopping cart",
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    backgroundColor:
                                                        ArgonColors.primary,
                                                    colorText: Colors.white,
                                                  );
                                                }),
                                          ),
                                        ]),
                                        ItemDivider(),
                                      ],
                                    );
                                  }).toList(),
                                );
                              }),
                          // Item(),
                          // ItemDivider(),
                        ],
                      )),
                ),
                // end of items
                SizedBox(height: size.height * 0.01),
                buttom_box_for_CheckOut(size),
                SizedBox(height: size.height * 0.03),
              ],
            )),
            // back icon
            icon(context, size),
          ]),
        ));
  }

  Container buttom_box_for_CheckOut(Size size) {
    return Container(
      height: size.height * 0.09,
      width: size.width * 0.92,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(33)),
      child: Card(
        color: kPrimaryLightColor,
        elevation: 9,
        child: Row(children: [
          Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
          ),
          // Expanded(
          //     flex: 2,
          //     child: Container(
          //         height: 50,
          //         child: ElevatedButton(
          //           onPressed: () {
          //             Navigator.pushReplacementNamed(context, '/home');
          //           },
          //           child: Text(
          //             'Shopping Cart',
          //           ),
          //         ))),
          Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // background
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CartPage(widget.resturantDocId)),
                      );
                    },
                    child: Text(
                      'CHECK OUT',
                      style: TextStyle(fontSize: 25),
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.only(
            right: 20,
          )),
        ]),
      ),
    );
  }

  Positioned icon(BuildContext context, Size size) {
    return Positioned(
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
    );
  }
}
