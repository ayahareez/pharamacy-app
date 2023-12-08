part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignIn extends AuthEvent {
  final AuthModel userModel;
  SignIn({required this.userModel});
}

class GuestSignIn extends AuthEvent {}

// class CheckUserSignInStatus extends AuthEvent {}

class SignUp extends AuthEvent {
  final AuthModel authModel;
  final UserModel userModel;
  SignUp({required this.authModel, required this.userModel});
}

class SignOut extends AuthEvent {}

class CheckIfAuth extends AuthEvent {}