import 'package:cloud_firestore/cloud_firestore.dart';

class HumeurModel {
  final String _id; // Identifiant de l'humeur
  final String _nom; // Nom de l'humeur
  final List<String> _films;

  var image; // Liste des films associés à l'humeur

  HumeurModel.fromSnapshot(DocumentSnapshot snapshot)
      : _id = snapshot.id, // Récupère l'ID de l'humeur à partir du snapshot
        _nom =
            snapshot['nom'], // Récupère le nom de l'humeur à partir du snapshot
        _films = List<String>.from(snapshot[
            'films']); // Récupère la liste des films associés à l'humeur à partir du snapshot

  String get id => _id; // Getter pour l'ID de l'humeur
  String get nom => _nom; // Getter pour le nom de l'humeur
  List<String> get films =>
      _films; // Getter pour la liste des films associés à l'humeur
}
