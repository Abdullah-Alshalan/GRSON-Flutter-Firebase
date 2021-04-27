import 'package:flutter/material.dart';
import 'package:GRSON/secondpages/theme/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.url,
      this.title = "Placeholder Title",
      this.cta = "",
      this.status,
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String url;
  final String cta;
  final String img;
  final Function tap;
  final String title;
  final String status;

  static void defaultFunc() {
    print("the function works!");
  }

  Future<void> _launchInBrowser() async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: ArgonColors.header, fontSize: 13)),
                          url != ''
                              ? GestureDetector(
                                  onTap: () {
                                    _launchInBrowser();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: ArgonColors.primary,
                                      ),
                                      Text('Location',
                                          style: TextStyle(
                                              color: ArgonColors.header,
                                              fontSize: 13)),
                                    ],
                                  ),
                                )
                              : Container(),
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                      color: status == 'CLOSE' ? Colors.red : Colors.green,
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: Container(),
                              ),
                              Text(status == 'CLOSE' ? 'CLOSE' : 'OPEN',
                                  style: TextStyle(
                                      color: ArgonColors.header, fontSize: 13)),
                            ],
                          ),
                          Text(cta,
                              style: TextStyle(
                                  color: ArgonColors.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
