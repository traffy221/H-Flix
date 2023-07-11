import 'package:cloud_firestore/cloud_firestore.dart';

class FilmHumeurModel {
  final String _filmId;
  final String _humeurId;

  FilmHumeurModel.fromSnapshot(DocumentSnapshot snapshot)
      : _filmId = snapshot['film_id'],
        _humeurId = snapshot['humeur_id'];

  String get filmId => _filmId;
  String get humeurId => _humeurId;
}
