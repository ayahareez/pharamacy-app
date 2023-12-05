import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/user/data/models/user_model.dart';

abstract class UsersRemoteDs {
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

class UsersRemoteDsImp implements UsersRemoteDs {
  final RemoteDbHelper dbHelper;

  UsersRemoteDsImp({required this.dbHelper});

  @override
  Future<void> addUser(UserModel userModel) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user != null ? user.uid : '';
    final String nameDocumentId = '$userId';
    return dbHelper.add(collectionName, userModel.toMap(),
        documentId: nameDocumentId);
  }

  @override
  Future<List<UserModel>> getUsers() async => List<UserModel>.from(
      await dbHelper.get(collectionName, UserModel.fromDoc));

  Future<UserModel?> getUserByAuthId(String authId) async {
    final List<UserModel> users = await getUsers();
    users.forEach((user) {
      print(user.userId);
    });
    try {
      return users.firstWhere((user) => user.userId == authId);
    } catch (e) {
      return null; // Return null if no matching user is found
    }
  }
}