import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'medicine_model.dart';

class CartData {
  String id;
  int qty;
  MedicineModel medicineModel;
  CartData({required this.id, required this.qty, required this.medicineModel});
}

class CartModel extends CartData {
  CartModel(
      {required super.id, required super.qty, required super.medicineModel});
  Map<String, dynamic> toMap() =>
      {'id': id, 'qty': qty, 'medicineModel': medicineModel};

  factory CartModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user != null ? user.uid : '';
    return CartModel(
        id: userId,
        qty: doc.data()['qty'],
        medicineModel: doc.data()['medicineModel']);
  }
}