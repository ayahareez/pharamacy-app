part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  List<ProductModel> products;
  ProductLoaded({required this.products});
}

class ProductError extends ProductState {
  final String error;
  ProductError({required this.error});
}