import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../welcomePages/constants.dart';

class CartManager {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> AddCart(itemName, itemPrice, itemImage, productId, docID) async {
    try {
      DocumentSnapshot cart = await getCart(productId, docID);
      if (cart.exists == false) {
        final User user = auth.currentUser;
        Map<String, dynamic> restaurantdata = {
          "itemName": itemName,
          "itemPrice": itemPrice,
          "quantity": 1,
          "itemImage": itemImage,
        };

        final restaurantRef = FirebaseFirestore.instance.collection('restaurant').doc(docID)
            .collection('cart')
            .doc(user.uid)
            .collection('products')
            .doc(productId);
        await restaurantRef.set(restaurantdata);
      } else {
        int currentQuantity = cart['quantity'];
        updateProductQty(productId, currentQuantity + 1, docID);
        print('cart quantity');
      }
      return 'Cart Saved';
    } catch (e) {
      print(e);
      return 'e';
    }
  }

  Future<String> addUserToCart(doumentId, docID) async {
    try {
      Map<String, dynamic> userdata = {
        "userId": auth.currentUser.uid,
      };
      final userdataRef = FirebaseFirestore.instance.collection('restaurant').doc(docID)
          .collection('cart')
          .doc(doumentId)
          .collection('products');

      await userdataRef.add(userdata);
      return 'Cart Saved';
    } catch (e) {
      print(e);
      return 'e';
    }
  }

  Future<DocumentSnapshot> getCart(productId, resturantDocId) async {
    try {
      final User user = auth.currentUser;
      final DocumentSnapshot cartData = await FirebaseFirestore.instance.collection('restaurant').doc(resturantDocId)
          .collection('cart')
          .doc(user.uid)
          .collection('products')
          .doc(productId)
          .get();
      return cartData;
    } catch (e) {}
    return null;
  }
  Future<int> getCartsForAll(resturantDocId) async {
    try {
      final User user = auth.currentUser;
      final QuerySnapshot cartData = await FirebaseFirestore.instance.collection('restaurant').doc(resturantDocId)
          .collection('cart')
          .doc(user.uid)
          .collection('products')
          .get();
      if(cartData.docs.isNotEmpty){
        checkCart = true;
      }
      return cartData.docs.length;
    } catch (e) {}
    return null;
  }

  Future<String> updateProductQty(productId, quantity, resturantDocId) async {
    try {
      final User user = auth.currentUser;
      final DocumentReference cartData = FirebaseFirestore.instance.collection('restaurant').doc(resturantDocId)
          .collection('cart')
          .doc(user.uid)
          .collection('products')
          .doc(productId);
      Map<String, dynamic> restaurantdate = {
        "quantity": quantity,
      };
      cartData.update(restaurantdate);
      return 'Got the data from Cart';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteCart(resturantDocId) async {
    try {
      final User user = auth.currentUser;
      final CollectionReference cartData = await FirebaseFirestore.instance.collection('restaurant').doc(resturantDocId)
          .collection('cart')
          .doc(auth.currentUser.uid)
          .collection('products');
      return cartData.get().then((snapshot) {
        snapshot.docs.forEach((doc) {
          print(doc.id);
          cartData
              .doc(doc.id)
              .delete()
              .then((value) => print("Cart Deleted"));
        });
      });
    } catch (e) {
      return 'e.message';
    }
  }
  Future<void> deleteProduct(resturantDocId, prodDocId) async {
    try {
      final User user = auth.currentUser;
      final DocumentReference cartData = await FirebaseFirestore.instance.collection('restaurant').doc(resturantDocId)
          .collection('cart')
          .doc(auth.currentUser.uid)
          .collection('products').doc(prodDocId);
      return cartData.delete();
    } catch (e) {
      return 'e.message';
    }
  }

}
