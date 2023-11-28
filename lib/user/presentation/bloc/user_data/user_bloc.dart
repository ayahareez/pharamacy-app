import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/data_source/user_remote_ds.dart';
import '../../../data/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersDBModel usersDBModel;
  UserBloc(this.usersDBModel) : super(UserDataInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is SetUserEvent) {
        emit(UserLoadingState());
        await usersDBModel.addUser(event.userModel);
        List<UserModel> users = await usersDBModel.getUsers();
        emit(UserLoadedState(usersModel: users));
      } else if (event is GetUserEvent) {
        emit(UserLoadingState());
        List<UserModel> users = await usersDBModel.getUsers();
        emit(UserLoadedState(usersModel: users));
      }
    });
  }
}