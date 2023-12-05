import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/medicine/data/data_source/product_local_ds.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

abstract class CartRemoteDs {
  Future setCart(CartModel cartModel);
  Future deleteCart(CartModel cartModel);
  Future updateCart(CartModel cartModel);
  Future<List<CartModel>> getCartsForUser();
  Future<void> deleteCartsForUser();
}

class CartRemoteDsImpl extends CartRemoteDs {
  final RemoteDbHelper dbHelper;
  CartRemoteDsImpl({required this.dbHelper});
  String cartsCollectionName = 'carts';
  //String cartCollectionName = 'cartsForUser';
  // @override
  // Future setCart(CartModel cartModel) async {
  //   print(cartModel.qty);
  //   await dbHelper.add(cartCollection, cartModel.toMap());
  //   print('from setCart');
  // }
  // @override
  // Future setCart(CartModel cartModel) async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   final String userId = user != null ? user.uid : '';
  //   // CollectionReference cartsCollection =
  //   //     FirebaseFirestore.instance.collection(cartsCollectionName);
  //   // DocumentReference userDocument = cartsCollection.doc(userId);
  //   // CollectionReference cartCollection = userDocument.collection(userId);
  //   // await cartCollection.add(cartModel.toMap());
  //   Future setMedicine(CartModel cartModel) =>
  //       dbHelper.add(cartsCollectionName, cartModel.toMap());
  //   print('from setCart');
  // }
  @override
  Future setCart(CartModel cartModel) async {
    print(cartModel.qty);
    print('before');
    await dbHelper.add(cartsCollectionName, cartModel.toMap());
    print('from setCart');
  }

  @override
  Future<List<CartModel>> getCartsForUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user != null ? user.uid : '';
    print('${userId} hello from getCartsForUser');
    List<CartModel> carts = List<CartModel>.from(
        await dbHelper.get(cartsCollectionName, CartModel.fromDoc));

    print(carts);
    List<CartModel> userCart = [];
    for (int i = 0; i < carts.length; i++) {
      print(carts[i].toString());
      if (carts[i].userId == userId) {
        print('${carts[i].userId} hello from getCartsForUser......');
        userCart.add(carts[i]);
      }
    }
    return userCart;
  }

  @override
  Future deleteCart(CartModel cartModel) =>
      dbHelper.delete(cartsCollectionName, cartModel.id);

  @override
  Future updateCart(CartModel cartModel) async {
    print('before cartUpdate');
    //print(cartModel.toString());
    await dbHelper.update(cartsCollectionName, cartModel.id, cartModel.toMap());
  }

  @override
  Future<void> deleteCartsForUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user != null ? user.uid : '';

    CollectionReference cartsCollection =
        FirebaseFirestore.instance.collection('carts');

    // Query to get all carts where userId is equal to the current user's ID
    QuerySnapshot userCartsSnapshot =
        await cartsCollection.where('userId', isEqualTo: userId).get();

    // Delete each cart document
    for (QueryDocumentSnapshot document in userCartsSnapshot.docs) {
      await document.reference.delete();
    }

    print('All carts for user $userId have been deleted.');
  }

  @override
  Future<List> get(Function dTOConverter, String userId) async {
    print('helloooooooooooooo');
    final snapshot = await FirebaseFirestore.instance
        .collection('cartsForUsers')
        .doc(userId)
        .collection(userId)
        .get();
    print('helloooooooooooooo after');
    return snapshot.docs.map((e) => dTOConverter(e)).toList();
  }
}