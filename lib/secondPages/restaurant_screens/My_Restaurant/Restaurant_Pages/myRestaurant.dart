import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'Information/homepage.dart';
import 'Queue/homePage.dart';
import 'Take_Away/takeaway.dart';

class RestaurantPage extends StatelessWidget {
  RestaurantPage({this.restaurantImage, this.restaurantName, this.locationUrl});

  final String restaurantImage;
  final String restaurantName;
  final String locationUrl;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: ArgonColors.bgColorScreen,
        body: TabBarView(
          children: [
            HomeInformationPage(
              restaurantName: restaurantName,
              restaurantImage: restaurantImage,
              locationUrl: locationUrl,
            ),
            HomeQueuePage(),
            HomeTake_AwayPage(),
          ],
        ),
      ),
    );
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
        "My Restaurant",
      ),
      elevation: 30,
      brightness: Brightness.dark,
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            child: Text(
              "Information",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Queues",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Take Away",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
