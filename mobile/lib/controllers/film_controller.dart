import 'package:front/models/film_model.dart';
import 'package:front/services/film_service.dart';

class FilmController {
  final FilmService _filmService = FilmService();

  // Obtient tous les films
  Future<List<FilmModel>> getAllFilms() async {
    try {
      return await _filmService.getAllFilms();
    } catch (e) {
      print('Error getting all films: $e');
      return [];
    }
  }

  // Obtient un film par son ID
  Future<FilmModel?> getFilmById(String id) async {
    try {
      return await _filmService.getFilmById(id);
    } catch (e) {
      print('Error getting film by ID: $e');
      return null;
    }
  }
}
