import 'dart:io';

import 'package:GRSON/model/Restaurant.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/components/rounded_input_location_field.dart';
import 'package:GRSON/welcomePages/components/rounded_input_person_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeInformationPage extends StatefulWidget {
  HomeInformationPage(
      {this.restaurantImage, this.restaurantName, this.locationUrl});

  String restaurantImage;
  String restaurantName;
  String locationUrl;

  @override
  _HomeInformationPageState createState() => _HomeInformationPageState();
}

class _HomeInformationPageState extends State<HomeInformationPage> {
  final RestaurantManager _restaurant = new RestaurantManager();

  File imageFile = null;
  final picker = ImagePicker();
  String filePath;
  String filename = DateTime.now().toString();
  bool updated = false;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
    });
    updateData();
  }

  Future updateData() async {
    if (imageFile != null) {
      setState(() {
        updated = true;
      });
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("images/$filename");
      UploadTask uploadTask = ref.putFile(imageFile);
      uploadTask.then((res) async {
        final String url = (await res.ref.getDownloadURL());
        widget.restaurantImage = url;
        String response = await _restaurant.updateResturant(
          widget.restaurantName,
          widget.locationUrl,
          widget.restaurantImage,
        );
        if (widget.restaurantImage != null) {
          setState(() {
            updated = false;
          });
        }
      });
      return "Data updated";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageFile == null
                              ? NetworkImage(widget.restaurantImage)
                              : FileImage(File(imageFile.path)),
                        ),
                        color: ArgonColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                          )),
                          add_restaurant_photo(),
                        ],
                      )),
                  information_box(context)
                ],
              )),
        ),
      ]),
    );
  }

  Container information_box(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.36,
        color: ArgonColors.white,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RoundedInputPersonField(
                      initialValue: widget.restaurantName,
                      onChanged: (value) {
                        widget.restaurantName = value;
                      },
                    ),
                    RoundedInputLocationField(
                      initialValue: widget.locationUrl,
                      onChanged: (value) {
                        widget.locationUrl = value;
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
                    child: updated == false
                        ? FlatButton(
                            textColor: ArgonColors.white,
                            color: ArgonColors.primary,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, 'Restaurant');
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(29.0),
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
                          )
                        : CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Padding add_restaurant_photo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 36,
            child: RaisedButton(
                textColor: ArgonColors.primary,
                color: ArgonColors.secondary,
                onPressed: pickImage,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 10, top: 10, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add Restaurant photo +",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}
