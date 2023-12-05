import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  final String productName, imageUrl, description;
  final int productId;
  final int price;
  ProductData(
      {required this.description,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.productId});
}

class ProductModel extends ProductData {
  ProductModel(
      {required super.description,
      required super.productName,
      required super.price,
      required super.imageUrl,
      required super.productId});
  Map<String, dynamic> toMap() => {
        'productName': productName,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
        'productId': productId
      };

  factory ProductModel.fromDoc(
          QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
      ProductModel(
          productName: doc.data()['productName'],
          price: doc.data()['price'],
          imageUrl: doc.data()['imageUrl'],
          description: doc.data()['description'],
          productId: doc.data()['productId']);
}