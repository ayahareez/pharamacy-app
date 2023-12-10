import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_source/cart_remore_ds.dart';
import '../../../data/models/cart_model.dart';
import '../../../data/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRemoteDs cartRemoteDs;
  CartBloc({required this.cartRemoteDs}) : super(CartInitial()) {
    on<CartEvent>((event, emit) async {
      try {
        if (event is GetCart) {
          emit(CartLoading());
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoaded(cartModels: carts));
        } else if (event is SetCart) {
          emit(CartLoading());
          await cartRemoteDs.setCart(event.cartModel);
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          //print("$carts looooooool");
          emit(CartLoaded(cartModels: carts));
        } else if (event is UpdateCart) {
          await cartRemoteDs.updateCart(event.cartModel);
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoaded(cartModels: carts));
        } else if (event is DeleteCart) {
          emit(CartLoading());
          await cartRemoteDs.deleteCart(event.cartModel);
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoaded(cartModels: carts));
        }
        if (event is DeleteCartsForUser) {
          emit(CartLoading());
          await cartRemoteDs.deleteCartsForUser();
          List<CartModel> carts = await cartRemoteDs.getCartsForUser();
          emit(CartLoaded(cartModels: carts));
        }
      } catch (e) {
        print('Error in MedicineBloc: $e');
        emit(CartError(error: '$e'));
      }
    });
  }
}