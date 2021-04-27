import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/constants.dart';
import 'package:flutter/material.dart';

class TakeAwayAccepet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<TakeAwayAccepet> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Take away"),
          // transparent: true,
        ),
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
                          color: kPrimaryLightColor,
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, bottom: 8),
                          child: InkWell(
                              onTap: () {
                               print('hello');
                              },
                              child: Row(
                                children: [
                                  Text("Abdulrahman "),
                                  TextButton(
                                      child: Text("Accepet ".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.all(15)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            // side:
                                            //     BorderSide(color: Colors.black)
                                          ))),
                                      onPressed: () => null),
                                  TextButton(
                                      child: Text("Decline ".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.all(15)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  ArgonColors.error),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            // side:
                                            //     BorderSide(color: Colors.black)
                                          ))),
                                      onPressed: () => print('hello')),
                                  // FlatButton(
                                  //   onPressed: () {
                                  //     // Respond to button press
                                  //     Navigator.pushReplacementNamed(
                                  //         context, '/home');
                                  //   },
                                  //   padding: const EdgeInsets.only(
                                  //       left: 4.0, top: 8, bottom: 8),
                                  //   child: Text("Accepet order"),
                                  //   color: Colors.green,
                                  // ),
                                  // FlatButton(
                                  //   onPressed: () {
                                  //     // Respond to button press
                                  //     Navigator.pushReplacementNamed(
                                  //         context, '/home');
                                  //   },
                                  //   padding: const EdgeInsets.only(
                                  //       left: 4.0, top: 8, bottom: 8),
                                  //   child: Text("Decline order"),
                                  //   color: ArgonColors.error,
                                  // )
                                ],
                              ))),
                      Container(
                          color: Color.fromRGBO(244, 245, 247, 1),
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, bottom: 8),
                          child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              // needed
                              child: Row(
                                children: [
                                  Text("cheese burger"),
                                  TextButton(
                                      child: Text("Accepet ".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.all(15)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            // side:
                                            //     BorderSide(color: Colors.green)
                                          ))),
                                      onPressed: () => null),
                                  TextButton(
                                      child: Text("Decline ".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.all(15)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  ArgonColors.error),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            // side:
                                            //     BorderSide(color: Colors.black)
                                          ))),
                                      onPressed: () => null),

                                  // FlatButton(
                                  //   onPressed: () {
                                  //     // Respond to button press
                                  //     Navigator.pushReplacementNamed(
                                  //         context, '/home');
                                  //   },
                                  //   padding: const EdgeInsets.only(
                                  //       left: 4.0, top: 8, bottom: 8),
                                  //   child: Text("Accepet order"),
                                  //   color: Colors.green,
                                  // ),
                                  // FlatButton(
                                  //   onPressed: () {
                                  //     // Respond to button press
                                  //     Navigator.pushReplacementNamed(
                                  //         context, '/home');
                                  //   },
                                  //   padding: const EdgeInsets.only(
                                  //       left: 4.0, top: 8, bottom: 8),
                                  //   child: Text("Decline order"),
                                  //   color: ArgonColors.error,
                                  // )
                                ],
                              ))),
                    ],
                  )),
            ),
          ]),
        ));
  }
}
