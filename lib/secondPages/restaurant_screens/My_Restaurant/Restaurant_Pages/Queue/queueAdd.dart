import 'package:GRSON/firebase/resturent.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/components/enum.dart';
import 'package:GRSON/welcomePages/components/rounded_number_field.dart';
import 'package:GRSON/welcomePages/components/rounded_queue_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QueueAdd extends StatefulWidget {
  QueueAdd({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<QueueAdd> {
  SingingCharacter temp = SingingCharacter.customer;
  String queueName = '';
  final Restaurant _restaurant = new Restaurant();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 25),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "Restaurant");
            },
          ),
          title: Text(
            "Add Queue",
          ),
          elevation: 30,
          brightness: Brightness.dark,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        body: SafeArea(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 24.0, right: 24.0, bottom: 32),
              child: Card(
                  elevation: 9,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.39,
                          color:
                              ArgonColors.white, // I will put background color
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RoundedQueueField(
                                        hintText: "Queue Name",
                                        onChanged: (value) {
                                          queueName = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: ArgonColors.muted,
                                    height: 10,
                                    thickness: 0.5,
                                    indent: 40,
                                    endIndent: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Center(
                                      child: FlatButton(
                                        textColor: ArgonColors.white,
                                        color: ArgonColors.primary,
                                        onPressed: () {
                                          addQueues(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(29.0),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 12,
                                                bottom: 12),
                                            child: Text("SAVE",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.0))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  )),
            ),
          ]),
        ));
  }

  addQueues(context) async {
    try {
      String queuesCreated =
          await _restaurant.createQueues(queueName);
      if (queuesCreated == "Queues Added!") {
        if (temp == SingingCharacter.customer) {
          Navigator.pop(context);
        } else {
          print("problem");
        }
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
