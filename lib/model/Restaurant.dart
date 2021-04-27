import 'package:GRSON/welcomePages/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Restaurant_class.dart';

class RestaurantManager {

  Future getRestaurant() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final DocumentReference myRestaurant = FirebaseFirestore.instance
        .collection('restaurant')
        .doc(_auth.currentUser.uid);

    try {
      DocumentSnapshot querySnapshot = await myRestaurant.get();
      return Restaurants.fromJson(querySnapshot.data());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future updateResturant(String displayName, String locationUrl,String restaurantImage ) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentReference myRestaurant = FirebaseFirestore.instance
          .collection('restaurant')
          .doc(_auth.currentUser.uid);

      Map<String, dynamic> restaurantdate = {
        "restaurantName": displayName,
        "locationUrl": locationUrl,
        "restaurantImage": restaurantImage
      };
      myRestaurant.update(restaurantdate);
      return "updated successfully";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future changeResturantStatus(String status) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentReference myRestaurant = FirebaseFirestore.instance
          .collection('restaurant')
          .doc(_auth.currentUser.uid);

      Map<String, dynamic> restaurantdate = {
        "Status" : status
      };
      myRestaurant.update(restaurantdate);
      return "updated Status successfully";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future getResturantStatus() async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentSnapshot myRestaurant = await FirebaseFirestore.instance
          .collection('restaurant')
          .doc(_auth.currentUser.uid).get();
      final restaurantONOff = myRestaurant.data()['Status'];
      return restaurantONOff;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getTakeAwayStatus() async {
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentSnapshot takeaway = await FirebaseFirestore.instance
          .collection('restaurant').doc(_auth.currentUser.uid).get();
      takeawayONOff = takeaway.data()['takeaway'];
      return "TakeAwayStatus got successfully";
    }
    catch(e){
      print(e);
    }
  }
  Future<String> updateTakeAwayStatus(takeawayONOff) async {
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      final DocumentSnapshot takeaway = await FirebaseFirestore.instance
          .collection('restaurant').doc(_auth.currentUser.uid).get();

      Map<String, dynamic> updateTakeAway = {
        "takeaway": takeawayONOff,
      };
      takeaway.reference.update(updateTakeAway);
      return "updated successfully";
    }
    catch(e){
      print(e);
    }
  }
  Future getRestaurantsList() async {
    final CollectionReference restaurantList =
        FirebaseFirestore.instance.collection('restaurant');

    List<Restaurants> itemsList = [];
    try {
      await restaurantList.get().then((querySnapshot) {
        itemsList.add(Restaurants.fromJson(querySnapshot.docs[0].data()));
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
