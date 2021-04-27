import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'Widgest/resQueue.dart';

class HomeQueuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 24.0, right: 24.0, bottom: 32),
          child: Card(
              elevation: 9,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                      child: desc_and_add_queue(context)),
                  Expanded(
                    flex: 4,
                      child: ResQueue()),
                ],
              )),
        ),
      ),
    ]);
  }

  Container desc_and_add_queue(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "you can add queue for the customer depends on the place of the queue and the max number of customer in each table ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 36,
                    child: RaisedButton(
                        textColor: ArgonColors.primary,
                        color: ArgonColors.secondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'Queue add');
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
                                  "Add queue +",
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
