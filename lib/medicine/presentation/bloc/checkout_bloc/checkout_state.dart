part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  List<CheckoutModel> checkoutModels;
  CheckoutLoaded({required this.checkoutModels});
}

class CheckoutError extends CheckoutState {
  final String error;
  CheckoutError({required this.error});
}