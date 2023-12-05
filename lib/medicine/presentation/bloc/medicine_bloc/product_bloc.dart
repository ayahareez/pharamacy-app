import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_source/product_remote_ds.dart';
import '../../../data/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRemoteDs productRemoteDs;
  ProductBloc({required this.productRemoteDs}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try {
        if (event is GetProducts) {
          emit(ProductLoading());
          List<ProductModel> products = await productRemoteDs.getMedicines();
          emit(ProductLoaded(products: products));
        } else if (event is SearchProducts) {
          emit(ProductLoading());
          List<ProductModel> searchResults =
              await productRemoteDs.searchProducts(event.query);
          emit(ProductLoaded(products: searchResults));
        }
      } catch (e) {
        print('${e} productbloc');
        emit(ProductError(error: "$e"));
      }
    });
  }
}