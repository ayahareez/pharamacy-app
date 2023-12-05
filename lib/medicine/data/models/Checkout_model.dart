import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy/medicine/data/models/product_model.dart';

import 'cart_model.dart';

class CheckoutData {
  final List<CartModel> cartModels;
  final String dateTime, fullName, phoneNumber;
  final int total;

  CheckoutData(
      {required this.cartModels,
      required this.dateTime,
      required this.fullName,
      required this.phoneNumber,
      required this.total});
}

class CheckoutModel extends CheckoutData {
  CheckoutModel(
      {required super.cartModels,
      required super.dateTime,
      required super.fullName,
      required super.phoneNumber,
      required super.total});
  Map<String, dynamic> toMap() {
    return {
      'cartModels': cartModels.map((cartModel) => cartModel.toMap()).toList(),
      'total': total,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }

  factory CheckoutModel.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    List<CartModel> cartModels = convertCartDataList(doc);
    return CheckoutModel(
      cartModels: cartModels,
      fullName: doc.data()['fullName'],
      phoneNumber: doc.data()['phoneNumber'],
      dateTime: doc.id,
      total: doc.data()['total'],
    );
  }

  static List<CartModel> convertCartDataList(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    print(doc.data()['cartModels']);
    List<CartModel> carts = [];
    for (int i = 0; i < doc.data()['cartModels'].length; i++) {
      CartModel cartModel = CartModel(
        qty: doc.data()['cartModels'][i]['qty'],
        medicineModel: ProductModel(
            description: doc.data()['cartModels'][i]['medicineModel']
                ['description'],
            productName: doc.data()['cartModels'][i]['medicineModel']
                ['productName'],
            price: (doc.data()['cartModels'][i]['medicineModel']['price']
                    as int?) ??
                0,
            imageUrl: doc.data()['cartModels'][i]['medicineModel']['imageUrl'],
            productId: doc.data()['cartModels'][i]['medicineModel']
                ['productId']),
        userId: '',
        id: '',
      );
      print(cartModel.medicineModel.price);
      carts.add(cartModel);
    }
    print(carts);
    return carts;
  }
}