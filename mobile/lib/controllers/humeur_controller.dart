import 'package:front/models/humeurs_model.dart';
import 'package:front/services/humeur_service.dart';

class HumeurController {
  final HumeurService _humeurService = HumeurService();

  // Obtient toutes les humeurs
  Future<List<HumeurModel>> getAllHumeurs() async {
    try {
      return await _humeurService.getAllHumeurs();
    } catch (e) {
      print('Error getting all humeurs: $e');
      return [];
    }
  }

  // Obtient une humeur par son ID
  Future<HumeurModel?> getHumeurById(String id) async {
    try {
      return await _humeurService.getHumeurById(id);
    } catch (e) {
      print('Error getting humeur by ID: $e');
      return null;
    }
  }
}
