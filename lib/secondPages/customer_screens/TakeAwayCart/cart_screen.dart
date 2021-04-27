import 'package:GRSON/model/TakeAwayCart.dart';
import 'package:GRSON/model/TakeAwayOrder.dart';
import 'package:GRSON/secondPages/customer_screens/TakeAwayOrderConfirm.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  CartPage(this.resturantDocId);

  final String resturantDocId;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartManager _cartPage = new CartManager();
  final OrderManager _orderManager = new OrderManager();
  QueryDocumentSnapshot Documents;
  bool showCart = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartLength().then((value) {
      if (value > 0) {
        setState(() {
          showCart = true;
        });
      }
    });
  }

  Future<int> getCartLength() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    QuerySnapshot documentStream = await FirebaseFirestore.instance
        .collection('restaurant')
        .doc(widget.resturantDocId)
        .collection('cart')
        .doc(auth.currentUser.uid)
        .collection('products')
        .get();
    return documentStream.size;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String newDoc;
    return Scaffold(
      backgroundColor: ArgonColors.bgColorScreen,
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('restaurant')
                    .doc(widget.resturantDocId)
                    .collection('cart')
                    .doc(auth.currentUser.uid)
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
                      Documents = document;
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
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
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (document['quantity'] > 1) {
                                                  _cartPage.updateProductQty(
                                                      document.id,
                                                      document['quantity'] - 1,
                                                      widget.resturantDocId);
                                                }
                                                if (document['quantity'] <= 1) {
                                                  _cartPage.deleteProduct(
                                                      widget.resturantDocId,
                                                      document.id);
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.white,
                                                size: 30,
                                              )),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 6, right: 6),
                                            child: Text(
                                              document['quantity'].toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: GestureDetector(
                                              onTap: () {
                                                _cartPage.updateProductQty(
                                                    document.id,
                                                    document['quantity'] + 1,
                                                    widget.resturantDocId);
                                              },
                                              child: Icon(
                                                Icons.add_circle,
                                                color: Colors.white,
                                                size: 30,
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
            // checkCart == null
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Center(
            //               child: Text(
            //             'There is notting in cart',
            //             style: TextStyle(fontSize: 20),
            //           )),
            //         ],
            //       )
            //     :
            showCart
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text("Continue Shopping".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          }),
                      SizedBox(
                        width: 50,
                      ),
                      TextButton(
                          child: Text("Checkout".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () async {
                            String orderCheck = await _orderManager.createOrder(
                              widget.resturantDocId,
                            );
                            _cartPage.deleteCart(widget.resturantDocId);
                            if (orderCheck == "Order is Placed") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TKOrderConfirm()),
                              );
                            }
                          }),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        'The cart is empty',
                        style: TextStyle(fontSize: 20),
                      ))
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
