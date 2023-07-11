import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:front/config/firebase_instance.dart';
import 'package:front/models/film_model.dart';

class FilmService {
  final CollectionReference _filmsCollection =
      FirebaseFirestore.instance.collection('films');
  final String collection = 'films';
  final db = FirebaseInstance.firestore;

  // Récupère tous les films
  Future<List<FilmModel>> getAllFilms() async {
    try {
      // Effectue une requête pour obtenir tous les documents dans la collection "films"
      QuerySnapshot querySnapshot = await _filmsCollection.get();
      // Mappe chaque document dans la liste des films en utilisant le constructeur FilmModel.fromSnapshot
      List<FilmModel> films =
          querySnapshot.docs.map((doc) => FilmModel.fromSnapshot(doc)).toList();
      return films;
    } catch (e) {
      print('Error getting films: $e');
      return [];
    }
  }

  ///@Todo get user by id
  // Future<FilmModel> getFilmById(String id) => db
  //     .collection(collection)
  //     .doc(id)
  //     .get()
  //     .then((doc) => FilmModel.fromSnapshot(doc));

  // Récupère un film par son ID
  Future<FilmModel?> getFilmById(String id) async {
    try {
      // Obtient le document spécifique dans la collection "films" en utilisant son ID
      DocumentSnapshot docSnapshot = await _filmsCollection.doc(id).get();
      if (docSnapshot.exists) {
        // Si le document existe, crée un objet FilmModel en utilisant le constructeur FilmModel.fromSnapshot

        FilmModel film = FilmModel.fromSnapshot(docSnapshot);

        return film;
      } else {
        // Si le document n'existe pas, retourne null
        return null;
      }
    } catch (e) {
      print('Error getting film by ID: $e');
      return null;
    }
  }
}
