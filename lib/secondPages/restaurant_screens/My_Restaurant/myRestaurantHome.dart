import 'package:GRSON/model/Restaurant.dart';
import 'package:GRSON/model/Restaurant_class.dart';
import 'package:GRSON/secondPages/widgets/card-square.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Restaurant_Pages/myRestaurant.dart';

class RestaurantHome extends StatefulWidget {
  RestaurantHome({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyRestaurantHome();
}

class _MyRestaurantHome extends State<RestaurantHome> {
  String state = "CLOSE";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final RestaurantManager _restaurants = new RestaurantManager();
  Restaurants restaurant;
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState{
    super.initState();
    _restaurants.getResturantStatus().then((value) {
      setState(() {
        state = value;
      });
    });

    _restaurants.getRestaurant().then((value) {
      setState(() {
        isloading = false;
        this.restaurant = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: open_close_button(),
      body: Container(
        padding: EdgeInsets.only(left: 14.0, right: 14.0, top: 34),
        child: Column(children: <Widget>[
          my_restaurant(),
          isloading ? CircularProgressIndicator() : restaurant_card(context),
        ]),
      ),
    );
  }

  Container my_restaurant() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: Text(
        'My restaurant',
        style: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w200),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(29),
      ),
      width: 300,
    );
  }

  CardSquare restaurant_card(BuildContext context) {
    if (this.restaurant != null) {
      return CardSquare(
          title: this.restaurant.restaurantName,
          img: this.restaurant.restaurantImage,
          tap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestaurantPage(
                        restaurantName: this.restaurant.restaurantName,
                        restaurantImage: this.restaurant.restaurantImage,
                        locationUrl: this.restaurant.locationUrl,
                      )),
            );
          });
    }
  }

  Card open_close_button() {
    return Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)), //if you change this
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), //change this !!!
          child: RaisedButton(
            onPressed: () {
              if (state == 'CLOSE') {
                setState(() {
                  state = 'OPEN';
                });
              } else {
                setState(() {
                  state = 'CLOSE';
                });
              }
              _restaurants.changeResturantStatus(state);
            },
            textColor: Colors.white,
            padding: EdgeInsets.all(0),
            child: Container(
              width: 170,
              height: 95,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: state == 'OPEN'
                      ? <Color>[
                          kPrimaryColor,
                          kSuccess, //second color
                        ]
                      : <Color>[
                          kPrimaryColor,
                          kError, //second color
                        ],
                ),
              ),
              padding: EdgeInsets.all(30),
              child: Column(children: [
                Text(state,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ]),
            ),
          ),
        ));
  }
}
