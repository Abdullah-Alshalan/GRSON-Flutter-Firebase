import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'TakeAwayCart.dart';

class OrderManager {
  final CartManager _cartPage = new CartManager();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> createOrderDetail(documentID, newDocId, docId) async {
    try {
      final User user = auth.currentUser;
      Map<String, dynamic> orderData = {
        "customerName": auth.currentUser.displayName,
        "status": 'Waiting',
        "userId": auth.currentUser.uid,
        "docId": docId,
      };
      final orderDataRef = FirebaseFirestore.instance
          .collection('restaurant')
          .doc(documentID)
          .collection('takeAwayOrders')
          .doc(newDocId);
      await orderDataRef.set(orderData);

      return 'Order is Placed';
    } catch (e) {
      return e.toString();
    }
  }

  Future updateOrder(documentID, newDocId, status) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentReference orderRef = FirebaseFirestore.instance
          .collection('restaurant')
          .doc(documentID)
          .collection('takeAwayOrders')
          .doc(newDocId);
      Map<String, dynamic> updateCart = {
        "status": status,
      };
      orderRef.update(updateCart);
      return "updated successfully";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> createOrder(resturantDocId) async {
    try {
      final User user = auth.currentUser;
      final QuerySnapshot cartData = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(resturantDocId)
          .collection('cart')
          .doc(user.uid)
          .collection('products')
          .get();
      if (cartData.docs.isNotEmpty) {
        var db = FirebaseFirestore.instance;
        var batch = db.batch();
        final restaurantRef = FirebaseFirestore.instance
            .collection('restaurant')
            .doc(resturantDocId)
            .collection('takeAwayOrders')
            .doc();
        final resturantProducts = restaurantRef.collection('products');
        cartData.docs.forEach((element) {
          batch.set(resturantProducts.doc(element.id), element.data());
        });
        batch.commit().then((value) async {
          await createOrderDetail(
              resturantDocId, restaurantRef.id, restaurantRef.id);
        });
      }
    } catch (e) {}
    return 'Order is Placed';
  }
}
