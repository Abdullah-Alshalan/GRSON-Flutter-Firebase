import 'dart:io';

import 'package:GRSON/firebase/resturent.dart';
import 'package:GRSON/secondPages/theme/Theme.dart';
import 'package:GRSON/welcomePages/components/enum.dart';
import 'package:GRSON/welcomePages/components/rounded_food_field.dart';
import 'package:GRSON/welcomePages/components/rounded_price_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  AddItem({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyBody();
}

class _MyBody extends State<AddItem> {
  final Restaurant _restaurant = new Restaurant();
  SingingCharacter temp = SingingCharacter.customer;
  String itemName = '';
  String itemPrice = '';
  String itemImage = '';
  var imageFile = null;
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
        itemImage = url;
        if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
          _restaurant.createTakeAway(itemName, itemPrice, itemImage);
          if (itemImage != null) {
            setState(() {
              updated = false;
            });
          }
        }
      });
      return "Data updated";
    }
  }

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
            "Add a New Item",
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
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageFile == null
                                    ? NetworkImage(
                                        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80")
                                    : FileImage(File(imageFile.path)),
                              ),
                              color: ArgonColors.white,
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
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 36,
                                      child: RaisedButton(
                                          textColor: ArgonColors.primary,
                                          color: ArgonColors.secondary,
                                          onPressed: pickImage,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10,
                                                  top: 10,
                                                  left: 8,
                                                  right: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Add an item picture +",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                ],
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.4,
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
                                      RoundedFoodField(
                                        hintText: "Item Name",
                                        onChanged: (value) {
                                          itemName = value;
                                        },
                                      ),
                                      RoundedPriceField(
                                        hintText: "Item Price",
                                        onChanged: (value) {
                                          itemPrice = value;
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
                                              onPressed: () async {
                                                if (itemName.isNotEmpty &&
                                                    itemPrice.isNotEmpty) {
                                                  Navigator.pushNamed(
                                                      context, 'Restaurant');
                                                } else {
                                                  print('hello');
                                                }
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
                                                  child: Text("Add",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20.0))),
                                            )
                                          : CircularProgressIndicator(),
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
}
