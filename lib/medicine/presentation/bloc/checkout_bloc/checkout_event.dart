part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class SetOrder extends CheckoutEvent {
  CheckoutModel checkoutModel;
  SetOrder({required this.checkoutModel});
}

class GetOrders extends CheckoutEvent {}