import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/medicine/data/data_source/product_local_ds.dart';
import 'package:pharmacy/medicine/data/models/Checkout_model.dart';

import '../models/product_model.dart';

abstract class CheckoutRemoteDs {
  Future setOrder(CheckoutModel checkoutModel);
  Future<List<CheckoutModel>> getOrders();
}

const collectionName = 'users';

class CheckoutRemoteDsImpl extends CheckoutRemoteDs {
  final RemoteDbHelper dbHelper;
  CheckoutRemoteDsImpl({required this.dbHelper});
  String orderCollection = 'order';

  Future<void> setOrder(CheckoutModel checkoutModel) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user != null ? user.uid : '';
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    print(formattedDate);
    //FieldValue currentTime = FieldValue.serverTimestamp();
    DocumentReference userDocument = usersCollection.doc(userId);
    CollectionReference ordersCollection = userDocument.collection('orders');
    // await ordersCollection.add(checkoutModel.toMap());
    await ordersCollection.doc(formattedDate).set(checkoutModel.toMap());
  }

  @override
  Future<List<CheckoutModel>> getOrders() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user != null ? user.uid : '';

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    DocumentReference userDocument = usersCollection.doc(userId);
    CollectionReference ordersCollection = userDocument.collection('orders');
    // List<CheckoutModel> orders =
    //     List<CheckoutModel>.from(await get(CheckoutModel.fromDoc, userId));
    QuerySnapshot querySnapshot = await ordersCollection
        .orderBy(FieldPath.documentId, descending: true)
        .get();

    List<CheckoutModel> orders = querySnapshot.docs
        .map((doc) => CheckoutModel.fromDoc(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>))
        .toList();
    return orders;
  }
}

@override
Future<List> get(Function dTOConverter, String userId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('orders')
      .get();
  return snapshot.docs.map((e) => dTOConverter(e)).toList();
}