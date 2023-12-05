part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class SetCart extends CartEvent {
  CartModel cartModel;
  SetCart({required this.cartModel});
}

class GetCart extends CartEvent {}

class DeleteCart extends CartEvent {
  CartModel cartModel;
  DeleteCart({required this.cartModel});
}

class UpdateCart extends CartEvent {
  CartModel cartModel;
  UpdateCart({required this.cartModel});
}

class DeleteCartsForUser extends CartEvent {}