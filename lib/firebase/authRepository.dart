import 'package:GRSON/welcomePages/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class AuthrRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    getUserForAuthCheck();
    return "Signed In";
  }

  Future<String> getUserForAuthCheck() async {
    try {
      final box = GetStorage();
      final User user = auth.currentUser;
      var document = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      box.write('UserRole', document.data()['role']);
      return 'SuccessFully Added in shared preferences';
    } catch (e) {
      return ("hi");
    }
  }

  Future<String> signUp(String email, String password, String username) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        user.user.updateProfile(
            displayName: username,
            photoURL:
                "https://firebasestorage.googleapis.com/v0/b/grson-86542.appspot.com/o/images%2F5e72e4.png?alt=media&token=fb5efea4-0f42-4fc0-b060-f8e2039de0d1");
      });
      getUserForAuthCheck();
      return "user signUp";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> saveUser(String role, deviceId) async {
    try {
      final User user = auth.currentUser;
      Map<String, dynamic> userdata = {
        "Email": user.email,
        "UserId": user.uid,
        "device_id": deviceId,
        "role": role,
      };
      final userRef =
          FirebaseFirestore.instance.collection('user').doc(user.uid);

      if ((await userRef.get()).exists) {
        print("User already exist");
      } else {
        await userRef.set(userdata);
      }
      return user.uid;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateUser(String displayName, String password) async {
    var response = await auth.currentUser.updateProfile(
      displayName: displayName,
    );
    auth.currentUser.updatePassword(password);
  }

  Future<String> getUser() async {
    try {
      final User user = auth.currentUser;
      String role;
      var document = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      loginRoleCheck = document.data()['role'];
      return document.data()['role'];
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
// getCurrentUser
}
