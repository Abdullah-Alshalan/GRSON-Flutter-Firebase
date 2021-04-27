import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'TakeAwayCart.dart';

class queUpOrderManager {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> createQUOrder(documentID, queOrderId) async {
    try {
      final User user = auth.currentUser;
      Map<String, dynamic> restaurantdata = {
        "customerName": auth.currentUser.displayName,
        "status": 'Waiting',
        "userId": auth.currentUser.uid,
      };

      final restaurantRef = FirebaseFirestore.instance
          .collection('restaurant')
          .doc(documentID).collection('queues').doc(queOrderId)
          .collection('orders')
          .doc(user.uid)
          .collection('queueOrders');
      await restaurantRef.add(restaurantdata);
      createQUOrderBool(documentID, queOrderId);
      return 'Order is Placed';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createQUOrderBool(documentID, queOrderId) async {
    try {
      final User user = auth.currentUser;
      Map<String, dynamic> orderData = {
        "QueueUp": true,
      };
      final orderDataRef =FirebaseFirestore.instance
          .collection('restaurant')
          .doc(documentID).collection('queues').doc(queOrderId)
          .collection('orders')
          .doc(user.uid);
      await orderDataRef.set(orderData);

      return 'Order is Placed';
    } catch (e) {
      return e.toString();
    }
  }

  Future updateOrder(firstDocId, secDocId, thirdDocId, status) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentReference orderRef =  FirebaseFirestore.instance
          .collection('restaurant')
          .doc(auth.currentUser.uid)
          .collection('queues')
          .doc(firstDocId)
          .collection('orders')
          .doc(secDocId)
          .collection('queueOrders')
          .doc(thirdDocId);
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
}
