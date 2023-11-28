import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/medicine/data/data_source/medicine_local_ds.dart';

import '../models/cart_model.dart';
import '../models/medicine_model.dart';

abstract class CartRemoteDs {
  Future setMedicine(CartModel medicineModel);
  Future<List<CartModel>> getMedicinesForUser();
}

class CartRemoteDsImpl extends CartRemoteDs {
  final RemoteDbHelper dbHelper;
  CartRemoteDsImpl({required this.dbHelper});
  String cartCollection = 'cart';

  @override
  Future setMedicine(CartModel cartModel) =>
      dbHelper.add(cartCollection, cartModel.toMap());

  @override
  Future<List<CartModel>> getMedicinesForUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user != null ? user.uid : '';
    List<CartModel> carts = List<CartModel>.from(
        await dbHelper.get(cartCollection, CartModel.fromDoc));
    List<CartModel> userCart = [];
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].id == userId) {
        userCart.add(carts[i]);
      }
    }
    return userCart;
  }
}