import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/medicine/data/data_source/product_local_ds.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDs {
  Future setMedicines();
  Future<List<ProductModel>> getMedicines();
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDsImpl extends ProductRemoteDs {
  final RemoteDbHelper dbHelper;
  ProductRemoteDsImpl({required this.dbHelper});
  String medicineCollection = 'medicine';
  @override
  Future<List<ProductModel>> getMedicines() async => List<ProductModel>.from(
      await dbHelper.get(medicineCollection, ProductModel.fromDoc));

  @override
  Future setMedicines() async {
    for (int i = 0; i < medicines.length; i++) {
      ProductModel medicineModel = medicines[i];
      await dbHelper.add(medicineCollection, medicineModel.toMap());
    }
  }

  Future setMedicine(ProductModel medicineModel) async {
    await dbHelper.add(medicineCollection, medicineModel.toMap());
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    // Implement the search logic using Firestore queries
    // For example, you can use where() to filter by productName
    var snapshot = await FirebaseFirestore.instance
        .collection(medicineCollection)
        .where('productName', isGreaterThanOrEqualTo: query)
        .get();
    print(
        "${List<ProductModel>.from(snapshot.docs.map((doc) => ProductModel.fromDoc(doc)))}fromsearch");
    return List<ProductModel>.from(
      snapshot.docs.map((doc) => ProductModel.fromDoc(doc)),
    );
  }
}