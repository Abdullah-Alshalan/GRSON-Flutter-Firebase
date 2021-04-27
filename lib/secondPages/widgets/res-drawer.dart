import 'package:GRSON/firebase/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:GRSON/secondpages/theme/Theme.dart';

import 'package:GRSON/secondpages/widgets/drawer-tile.dart';
import 'package:get_storage/get_storage.dart';

class ResDrawer extends StatefulWidget {
  final String currentPage;
  ResDrawer({
    this.currentPage,
  });

  @override
  _ResDrawerState createState() => _ResDrawerState();
}

class _ResDrawerState extends State<ResDrawer> {
  final AuthrRepository _auth = new AuthrRepository();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    'GRSON',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (widget.currentPage != "Restaurant") {
                      Navigator.pushReplacementNamed(context, 'Restaurant');
                    }
                  },
                  iconColor: ArgonColors.primary,
                  title: "Home",
                  isSelected:
                      widget.currentPage == "Restaurant" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (widget.currentPage != "resprofile")
                      Navigator.pushReplacementNamed(context, 'resprofile');
                  },
                  iconColor: ArgonColors.warning,
                  title: "profile",
                  isSelected:
                      widget.currentPage == "resprofile" ? true : false),
              DrawerTile(
                icon: Icons.logout,
                onTap: () {
                  signOut(context);
                box.remove('UserData');
                },
                iconColor: ArgonColors.primary,
                title: "Sign Out",
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("DOCUMENTATION",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.airplanemode_active,
                      // onTap: _launchURL,
                      iconColor: ArgonColors.muted,
                      title: "Getting Started",
                      isSelected: widget.currentPage == "Getting started"
                          ? true
                          : false),
                ],
              )),
        ),
      ]),
    ));
  }

  signOut(context)  {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, 'WelcomePage');
  }
}