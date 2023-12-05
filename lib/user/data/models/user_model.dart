import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacy/user/data/data_source/auth_remote_ds.dart';

class UserModel {
  final String name, userId;

  UserModel({required this.name, required this.userId});

  Map<String, dynamic> toMap() => {
        'name': name,
      };

  factory UserModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    print('${doc.id} from testing docId');
    return UserModel(name: doc.data()['name'], userId: doc.id);
  }
  @override
  String toString() {
    return 'UserModel{name: $name, id: $userId}'; // Adjust the format based on your properties
  }
}