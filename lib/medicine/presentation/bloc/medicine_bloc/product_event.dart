part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class SetProducts extends ProductEvent {}

class GetProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts({required this.query});
}