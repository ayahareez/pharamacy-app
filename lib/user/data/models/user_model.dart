import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name, id;

  UserModel({required this.name, required this.id});

  Map<String, dynamic> toMap() => {
        'name': name,
      };

  factory UserModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user != null ? user.uid : '';
    print('$userId ayaaaaaaaaaaaaa');
    return UserModel(
      name: doc.data()['name'],
      id: userId,
    );
  }
  @override
  String toString() {
    return 'UserModel{name: $name, id: $id}'; // Adjust the format based on your properties
  }
}