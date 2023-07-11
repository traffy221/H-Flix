import 'package:front/models/film_model.dart';
import 'package:front/models/humeurs_model.dart';
import 'package:front/services/film_service.dart';
import 'package:front/services/humeur_service.dart';

class HumeurFilmsService {
  final HumeurService _humeurService = HumeurService();
  final FilmService _filmService = FilmService();

  // Récupère les films correspondant à une humeur spécifique
  Future<List<FilmModel>> getFilmsByHumeur(String humeurId) async {
    try {
      // Récupère l'humeur par son ID
      HumeurModel? humeur = await _humeurService.getHumeurById(humeurId);

      if (humeur != null) {
        List<FilmModel> films = [];

        // Parcours les ID des films associés à l'humeur
        for (String filmId in humeur.films) {
          // Récupère le film par son ID
          FilmModel? film = await _filmService.getFilmById(filmId);
          if (film != null) {
            films.add(film);
          }
        }

        return films;
      } else {
        print('Humeur not found');
        return [];
      }
    } catch (e) {
      print('Error getting films by humeur: $e');
      return [];
    }
  }
}

final humeurFilmService = HumeurFilmsService();
