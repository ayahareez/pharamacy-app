import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';

import '../../data/data_source/medicine_remote_ds.dart';
import '../../data/models/medicine_model.dart';

part 'medicine_event.dart';
part 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  MedicineRemoteDs medicineRemoteDs;
  MedicineBloc({required this.medicineRemoteDs}) : super(MedicineInitial()) {
    on<MedicineEvent>((event, emit) async {
      try {
        if (event is GetMedicines) {
          emit(MedicineLoading());
          List<MedicineModel> medicineModel =
              await medicineRemoteDs.getMedicines();
          emit(MedicineLoaded(medicines: medicineModel));
        }
      } catch (e) {
        emit(MedicineError(error: '$e'));
      }
    });
  }
}