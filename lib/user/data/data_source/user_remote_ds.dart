import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/user/data/models/user_model.dart';

abstract class UsersDBModel {
  ///add user data to [FireStore]
  ///
  /// throw an error
  Future<void> addUser(UserModel userModel);

  ///get user from  [FireStore]
  ///
  /// throw an error
  Future<List<UserModel>> getUsers();

  Future<UserModel?> getUserByAuthId(String authId);
}

const collectionName = 'users';

class UserDBModelImp implements UsersDBModel {
  final RemoteDbHelper dbHelper;

  UserDBModelImp({required this.dbHelper});

  @override
  Future<void> addUser(UserModel userModel) =>
      dbHelper.add(collectionName, userModel.toMap());

  @override
  Future<List<UserModel>> getUsers() async => List<UserModel>.from(
      await dbHelper.get(collectionName, UserModel.fromDoc));

  Future<UserModel?> getUserByAuthId(String authId) async {
    final List<UserModel> users = await getUsers();
    users.forEach((user) {
      print(user.id);
    });
    try {
      return users.firstWhere((user) => user.id == authId);
    } catch (e) {
      return null; // Return null if no matching user is found
    }
  }
}