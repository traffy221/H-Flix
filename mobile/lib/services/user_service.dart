import 'package:front/config/firebase_instance.dart';

import '../models/user_model.dart';

class UserService {
  final String collection = "users";
  final db = FirebaseInstance.firestore;

  //s'inscrire
  void createUser({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    required String username,
    int votes = 0,
    double rating = 0,
  }) {
    db.collection(collection).doc(id).set({
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "username": username,
      "votes": votes,
      "rating": rating,
    });
  }

  //maj user
  void updateUser(Map<String, dynamic> values) {
    db.collection(collection).doc(values['id']).update(values);
  }

  //get user by id
  Future<UserModel> getUserById(String id) => db
      .collection(collection)
      .doc(id)
      .get()
      .then((doc) => UserModel.fromSnapshot(doc));

  //se connecter

  //se deconnecter
}
