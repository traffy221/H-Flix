import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String _id;
  final String _firstname;
  final String _lastname;
  final String _email;
  final String _username;

  final int _votes;
  final double _rating;

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : _id = snapshot.id,
        _firstname = snapshot['firstname'],
        _lastname = snapshot['lastname'],
        _email = snapshot['email'],
        _username = snapshot['username'],
        _votes = snapshot['votes'],
        _rating = snapshot['rating'];

  String get id => _id;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get email => _email;
  String get username => _username;
  int get votes => _votes;
  double get rating => _rating;
}
