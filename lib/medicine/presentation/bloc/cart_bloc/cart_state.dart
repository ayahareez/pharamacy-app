part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  List<CartModel> cartModels;
  CartLoaded({required this.cartModels});
}

class CartError extends CartState {
  final String error;
  CartError({required this.error});
}