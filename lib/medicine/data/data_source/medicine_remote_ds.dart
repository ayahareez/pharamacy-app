import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/medicine/data/data_source/medicine_local_ds.dart';

import '../models/medicine_model.dart';

abstract class MedicineRemoteDs {
  Future setMedicines();
  Future<List<MedicineModel>> getMedicines();
}

class MedicineRemoteDsImpl extends MedicineRemoteDs {
  final RemoteDbHelper dbHelper;
  MedicineRemoteDsImpl({required this.dbHelper});
  String medicineCollection = 'medicine';
  @override
  Future<List<MedicineModel>> getMedicines() async => List<MedicineModel>.from(
      await dbHelper.get(medicineCollection, MedicineModel.fromDoc));

  @override
  Future setMedicines() async {
    for (int i = 0; i < medicines.length; i++) {
      MedicineModel medicineModel = medicines[i];
      await dbHelper.add(medicineCollection, medicineModel.toMap());
    }
  }

  Future setMedicine(MedicineModel medicineModel) async {
    await dbHelper.add(medicineCollection, medicineModel.toMap());
  }
}