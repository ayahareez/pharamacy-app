import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy/medicine/data/models/Checkout_model.dart';

import '../../../data/data_source/checkout_remote_ds.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutRemoteDs checkoutRemoteDs;
  CheckoutBloc({required this.checkoutRemoteDs}) : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) async {
      try {
        if (event is SetOrder) {
          emit(CheckoutLoading());
          await checkoutRemoteDs.setOrder(event.checkoutModel);
          List<CheckoutModel> checkoutModels =
              await checkoutRemoteDs.getOrders();
          emit(CheckoutLoaded(checkoutModels: checkoutModels));
        } else if (event is GetOrders) {
          emit(CheckoutLoading());
          List<CheckoutModel> checkoutModels =
              await checkoutRemoteDs.getOrders();
          emit(CheckoutLoaded(checkoutModels: checkoutModels));
        }
      } catch (e) {
        print(e);
        emit(CheckoutError(error: '$e'));
      }
    });
  }
}