import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/models/film_model.dart';
import 'package:front/models/humeurs_model.dart';

class HumeurService {
  final CollectionReference _humeursCollection =
      FirebaseFirestore.instance.collection('humeurs');

  // Récupère toutes les humeurs
  Future<List<HumeurModel>> getAllHumeurs() async {
    try {
      // Effectue une requête pour obtenir tous les documents dans la collection "humeur"
      QuerySnapshot querySnapshot = await _humeursCollection.get();
      // Mappe chaque document dans la liste des humeurs en utilisant le constructeur HumeurModel.fromSnapshot
      List<HumeurModel> humeurs = querySnapshot.docs
          .map((doc) => HumeurModel.fromSnapshot(doc))
          .toList();

      return humeurs;
    } catch (e) {
      print('Error getting humeurs: $e');
      return [];
    }
  }

  // Récupère une humeur par son ID
  Future<HumeurModel?> getHumeurById(String id) async {
    try {
      // Obtient le document spécifique dans la collection "humeur" en utilisant son ID
      DocumentSnapshot docSnapshot = await _humeursCollection.doc(id).get();
      if (docSnapshot.exists) {
        // Si le document existe, crée un objet HumeurModel en utilisant le constructeur HumeurModel.fromSnapshot
        HumeurModel humeur = HumeurModel.fromSnapshot(docSnapshot);
        return humeur;
      } else {
        // Si le document n'existe pas, retourne null
        return null;
      }
    } catch (e) {
      print('Error getting humeur by ID: $e');
      return null;
    }
  }

  // Récupère tous les films associés à une humeur
  Future<List<FilmModel>> getFilmsByHumeurId(String humeurId) async {
    try {
      // Effectue une requête pour obtenir tous les documents dans la collection "films"
      QuerySnapshot querySnapshot =
          await _humeursCollection.doc(humeurId).collection('films').get();
      // Mappe chaque document dans la liste des films en utilisant le constructeur FilmModel.fromSnapshot
      List<FilmModel> films =
          querySnapshot.docs.map((doc) => FilmModel.fromSnapshot(doc)).toList();
      return films;
    } catch (e) {
      print('Error getting films by humeur ID: $e');
      return [];
    }
  }
}

final humeurService = HumeurService();
