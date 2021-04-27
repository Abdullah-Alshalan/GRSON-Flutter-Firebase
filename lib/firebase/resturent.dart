import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Restaurant {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> createRestaurant() async {
    try {
      final User user = auth.currentUser;
      Map<String, dynamic> restaurantdata = {
        "ownerId": user.uid,
        "restaurantImage": "https://firebasestorage.googleapis.com/v0/b/grson-86542.appspot.com/o/images%2F5e72e4.png?alt=media&token=fb5efea4-0f42-4fc0-b060-f8e2039de0d1",
        "restaurantName": "restaurantName",
        "locationUrl": "",
        "Status": "CLOSE",
        "takeaway": false,
      };
      final restaurantRef = FirebaseFirestore.instance
          .collection('restaurant').doc(user.uid);
      await restaurantRef.set(restaurantdata);
      return 'Restaurant Added!';
    } catch (e) {
      return e.toString();
    }
  }
  Future<String> createQueues(queueName) async {
    try {
      final User user = auth.currentUser;
      Map<String, dynamic> queuesData = {
        "queuesName": queueName,
      };
      final restaurantRef = FirebaseFirestore.instance
          .collection('restaurant').doc(user.uid).collection('queues');
      await restaurantRef.add(queuesData);
      return 'Queues Added!';
    } catch (e) {
      return e.toString();
    }
  }
  Future<String> deteleQueues(documnetId) async {
    try {
      final User user = auth.currentUser;
      final restaurantRef = FirebaseFirestore.instance
          .collection('restaurant').doc(user.uid).collection('queues');
      await restaurantRef.doc(documnetId).delete();
      return 'Queues Deleted!';
    } catch (e) {
      return e.toString();
    }
  }
  Future<String> createTakeAway(itemName, itemPrice, itemImage) async {
    try {

      final User user = auth.currentUser;
      Map<String, dynamic> queuesData = {
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemImage": itemImage,
      };
      final restaurantRef = FirebaseFirestore.instance
          .collection('restaurant').doc(user.uid).collection('takeaway');
      await restaurantRef.add(queuesData);
      return 'Takeaway Added!';
    } catch (e) {
      return e.toString();
    }
  }
  Future<String> deteleTakeAway(documnetId) async {
    try {
      final User user = auth.currentUser;
      final restaurantRef = FirebaseFirestore.instance
          .collection('restaurant').doc(user.uid).collection('takeaway');
      await restaurantRef.doc(documnetId).delete();
      return 'TakeAway Deleted!';
    } catch (e) {
      return e.toString();
    }
  }

}
