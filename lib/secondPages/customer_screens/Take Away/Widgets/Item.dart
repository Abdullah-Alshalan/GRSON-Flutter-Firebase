import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Row(children: [
          //picture only
          Container(
            height: 60,
            width: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                // fit: BoxFit.fitWidth,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"),
              ),
            ),
          ),
          // Name of item
          Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
          ),
          Expanded(
            child: Text(
              "Cheese Burger",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "39 SAR",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: TextButton(
                child: Text("Order ".toUpperCase(), style: TextStyle(fontSize: 20)),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          // side:
                          //     BorderSide(color: Colors.black)
                        ))),
                onPressed: () => null),
          )
        ]));
  }
}
