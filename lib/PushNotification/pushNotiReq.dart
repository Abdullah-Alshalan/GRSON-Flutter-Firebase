import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future getRestaurant(userId, message) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final DocumentSnapshot getDeviceToken =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();
    String deviceId = getDeviceToken.data()['device_id'];
    sendPushNotifications(deviceId, message);
    return deviceId;
  } catch (e) {
    return null;
  }
}
// {
// "title": "Your Title",
// "text": "Your Text"
// },

Future<bool> sendPushNotifications(deviceId, message) async {
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  var key =
      'AAAAy-EwTAI:APA91bGaXUc6OIfsu1XaFk0l7-FSnlqjYKPXovjCaLLN_qtBktiEoCPQVQlDTNs9wMwTk7bbZ8xXJoA1LqEMVRApUgwnuWQ5VdQkJl3Gahp12rD713pD1TWYxYYk-2k9vdO4GRIPOGVF';
  final data = {"notification": message, "to": deviceId};
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=' + key,
  };

  final response = await http.post(url,
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    // on success do sth
    print('test ok push CFM');
    return true;
  } else {
    print(' CFM error');
    // on failure do sth
    return false;
  }
}
