import 'package:cloud_firestore/cloud_firestore.dart';

class FilmModel {
  final String _id;
  final String _titre;
  final String _genre;
  final String _dateSortie;
  final String _realisateur;
  final String _casting;
  // final String _synopsis;
  final int _noteMoyenne;

  FilmModel.fromSnapshot(DocumentSnapshot snapshot)
      : _id = snapshot.id,
        _titre = snapshot['titre'],
        _genre = snapshot['genre'],
        _dateSortie = snapshot['dateSortie'],
        _realisateur = snapshot['realisateur'],
        _casting = snapshot['casting'],
        // _synopsis = snapshot['synopsis'],
        _noteMoyenne = snapshot['noteMoyenne'];

  String get id => _id;
  String get titre => _titre;
  String get genre => _genre;
  String get dateSortie => _dateSortie;
  String get realisateur => _realisateur;
  String get casting => _casting;
  // String get synopsis => _synopsis;
  int get noteMoyenne => _noteMoyenne;
}
