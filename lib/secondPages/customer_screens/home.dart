import 'package:GRSON/firebase/authRepository.dart';
import 'package:GRSON/secondPages/widgets/cus-drawer.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/secondpages/theme/Theme.dart';
import 'package:get_storage/get_storage.dart';
import 'Queue/homePage.dart';
import 'Take Away/homePage.dart';

final Map<String, Map<String, String>> homeCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
        "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image":
        "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image":
        "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image":
        "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  }
};

class CHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ArgonColors.bgColorScreen,
          appBar: appBar(),
          drawer: CusDrawer(
            currentPage: "Home",
          ),
          body: TabBarView(
            children: [
              HomeQueuePage(),
              HomeTakeAwayPage(),
            ],
          ),
        ));
  }

  AppBar appBar() {
    final box = GetStorage();
    AuthrRepository _auth = new AuthrRepository();
    return AppBar(
      actions: <Widget>[
        Container(
          width: 55,
          child: Icon(Icons.search, size: 25),
        ),
        // Container(
        //   width: 55,
        //   child: IconButton(icon: Icon(Icons.notifications_none_outlined, size: 25), onPressed: ()  {
        //   }),
        // ),
      ],
      title: Text(
        "Custumer's page",
      ),
      elevation: 30,
      brightness: Brightness.dark,
      bottom: TabBar(indicatorColor: Colors.white, tabs: [
        Tab(
          child: Text(
            "Queue Up",
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
      ]),
    );
  }
}
