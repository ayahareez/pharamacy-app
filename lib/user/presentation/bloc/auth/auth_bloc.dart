import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy/user/presentation/bloc/user_data/user_bloc.dart';

import '../../../data/data_source/auth_remote_ds.dart';
import '../../../data/data_source/user_remote_ds.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthinticationRemoteDs authinticationRemoteDs;
  final UsersRemoteDs usersDBModel;
  AuthBloc({required this.usersDBModel, required this.authinticationRemoteDs})
      : super(UserUnauthorized()) {
    on<AuthEvent>((event, emit) async {
      print(event);
      try {
        if (event is SignUp) {
          emit(UserLoadingState());
          await authinticationRemoteDs.signUp(event.authModel);
          await usersDBModel.addUser(event.userModel);
          emit(UserAuthorizedState());
        } else if (event is SignIn) {
          emit(UserLoadingState());
          await authinticationRemoteDs.signIn(event.userModel);
          if (authinticationRemoteDs.checkIfAuth()) {
            emit(UserAuthorizedState());
          } else {
            emit(UserUnauthorized());
          }
        } else if (event is CheckIfAuth) {
          emit(UserLoadingState());
          final isSigned = authinticationRemoteDs.checkIfAuth();
          final bool anon = authinticationRemoteDs.checkUserSignInStatus();
          // print(isSigned);
          if (isSigned && anon) {
            emit(UserAnonymousState());
          } else if (isSigned) {
            emit(UserAuthorizedState());
          } else {
            emit(UserUnauthorized());
          }
        } else if (event is SignOut) {
          emit(UserLoadingState());
          await authinticationRemoteDs.signOut();
          emit(UserUnauthorized());
        } else if (event is GuestSignIn) {
          emit(UserLoadingState());
          print('from GuestSignIn');
          await authinticationRemoteDs.signInAsGuest();
          emit(UserAnonymousState());
        }
        // else if (state is CheckUserSignInStatus) {
        //   bool anon = authinticationRemoteDs.checkUserSignInStatus();
        //   if (anon) {
        //     emit(UserAnonymousState());
        //   } else {
        //     emit(UserAuthorizedState());
        //   }
        // }
      } catch (e) {
        // Handle the exception here
        emit(UserErrorState(
            error: 'please enter your Credentials correctly,or sign up '));
      }
    });
  }
  // bool isUserAnonymous() {
  //   return authinticationRemoteDs.checkUserSignInStatus();
  // }
}