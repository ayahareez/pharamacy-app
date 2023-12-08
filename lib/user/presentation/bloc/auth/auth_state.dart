part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class UserUnauthorized extends AuthState {}

class UserLoadingState extends AuthState {} //طالما في Future

class UserAuthorizedState extends AuthState {}

class UserAnonymousState extends AuthState {}

class UserErrorState extends AuthState {
  final String error;

  UserErrorState({required this.error});
}