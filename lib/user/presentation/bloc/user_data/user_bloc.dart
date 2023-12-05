import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../data/data_source/auth_remote_ds.dart';
import '../../../data/data_source/user_remote_ds.dart';
import '../../../data/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRemoteDs usersDBModel;
  final AuthinticationRemoteDs authinticationRemoteDs;
  UserBloc({required this.usersDBModel, required this.authinticationRemoteDs})
      : super(UserDataInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is SetUserEvent) {
        emit(UserLoadingState());
        // await usersDBModel.addUser(event.userModel);
        add(GetUserEvent());
      } else if (event is GetUserEvent) {
        emit(UserLoadingState());
        User? user = FirebaseAuth.instance.currentUser;
        String userId = user != null ? user.uid : '';
        // String userId = authinticationRemoteDs.getUserId();
        UserModel userModel = await usersDBModel.getUserByAuthId(userId) ??
            UserModel(
              name: 'name',
              userId: ' userId',
            );
        print(userModel.toString());
        print("${userId} userbloc");
        emit(UserLoadedState(usersModel: userModel));
      }
    });
  }
}