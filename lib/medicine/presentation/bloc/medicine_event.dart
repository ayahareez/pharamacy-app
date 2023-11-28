part of 'medicine_bloc.dart';

@immutable
abstract class MedicineEvent {}

class SetMedicines extends MedicineEvent {}

class GetMedicines extends MedicineEvent {}

class SetCart extends MedicineEvent {
  CartModel cartModel;
  SetCart({required this.cartModel});
}

class GetCart extends MedicineEvent {}