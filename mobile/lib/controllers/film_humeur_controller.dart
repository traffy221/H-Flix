import 'package:front/models/film_model.dart';
import 'package:front/services/humeur_films_service.dart';

class HumeurFilmsController {
  final HumeurFilmsService _humeurFilmsService = HumeurFilmsService();

  // Obtient les films correspondant à une humeur spécifique
  Future<List<FilmModel>> getFilmsByHumeur(String humeurId) async {
    try {
      return await _humeurFilmsService.getFilmsByHumeur(humeurId);
    } catch (e) {
      print('Error getting films by humeur: $e');
      return [];
    }
  }
}
