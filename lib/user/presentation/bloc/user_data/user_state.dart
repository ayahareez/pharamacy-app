part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserDataInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> usersModel;

  UserLoadedState({required this.usersModel});
}