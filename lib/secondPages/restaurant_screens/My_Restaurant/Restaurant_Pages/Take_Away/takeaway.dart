import 'package:GRSON/model/Restaurant.dart';
import 'package:GRSON/secondPages/restaurant_screens/My_Restaurant/Restaurant_Pages/Take_Away/widgets/resTakeAway.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:flutter/material.dart';

class HomeTake_AwayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<HomeTake_AwayPage> {
  final RestaurantManager _restaurant = new RestaurantManager();

  void initState() {
    _restaurant.getTakeAwayStatus();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: size.height * 0),
              Text("Turn Take Away on/off",
                  style: TextStyle(color: ArgonColors.text, fontSize: 30)),
              Switch.adaptive(
                value: takeawayONOff,
                onChanged: (bool newValue) {
                  setState(() {
                    takeawayONOff = newValue;
                  });
                  _restaurant.updateTakeAwayStatus(takeawayONOff);
                },
                activeColor: ArgonColors.primary,
              ),
              SizedBox(height: size.height * 0),
            ],
          ),
        ),
        if (takeawayONOff) Expanded(flex: 10, child: buildPadding(context)),
        Expanded(flex: 4, child: Container()),
      ]),
    ));
  }

  Padding buildPadding(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 15.0, right: 15.0, bottom: 10),
      child: Card(
          elevation: 9,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: add_item_box(context),
              ),
              Expanded(
                flex: 6,
                child: ResTakeAway(),
              ),
            ],
          )),
    );
  }

  Container add_item_box(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            color: Color.fromRGBO(244, 245, 247, 1),
            border: Border(
                bottom: BorderSide(
              width: 0.5,
              color: ArgonColors.muted,
            ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 36,
                    child: RaisedButton(
                        textColor: ArgonColors.primary,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'Add item');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10, left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add item +",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ],
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
