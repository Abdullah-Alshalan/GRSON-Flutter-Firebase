import 'package:flutter/material.dart';

class QueueItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: kPrimaryLightColor,
        padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
        child: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Row(
              children: [
                Text("in door 1"),
                TextButton(
                    child: Text("Accepet next".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () => null),
              ],
            )));
  }
}
