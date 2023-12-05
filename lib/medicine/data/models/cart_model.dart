import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product_model.dart';

class CartData {
  final String userId, id;
  int qty;
  final ProductModel medicineModel;
  CartData(
      {required this.qty,
      required this.medicineModel,
      required this.userId,
      required this.id});
}

class CartModel extends CartData {
  CartModel(
      {required super.qty,
      required super.medicineModel,
      required super.userId,
      required super.id});
  Map<String, dynamic> toMap() => {
        'qty': qty,
        'medicineModel': medicineModel.toMap(),
        'userId': FirebaseAuth.instance.currentUser!.uid,
      };

  factory CartModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    print('${doc.id} from docId');
    return CartModel(
        qty: doc.data()['qty'],
        medicineModel: ProductModel(
            productName: doc.data()['medicineModel']['productName'],
            price: (doc.data()['medicineModel']['price'] as int?) ?? 0,
            imageUrl: doc.data()['medicineModel']['imageUrl'],
            description: doc.data()['medicineModel']['description'],
            productId: doc.data()['medicineModel']['productId']),
        userId: doc.data()['userId'],
        id: doc.id);
  }
  @override
  String toString() {
    return 'cartModel{ userId: $userId, productName: ${medicineModel.productName},price: ${medicineModel.price},imageUrl: ${medicineModel.imageUrl},description: ${medicineModel.description}';
  }
}