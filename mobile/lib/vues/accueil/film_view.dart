import 'package:flutter/material.dart';
import 'package:front/models/humeurs_model.dart';
import 'package:front/models/film_model.dart';

class FilmView extends StatelessWidget {
  final HumeurModel humeur;
  final List<FilmModel>? films;

  const FilmView({required this.humeur, this.films});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FilmView'),
      ),
      body: ListView.builder(
        itemCount: films!.length,
        itemBuilder: (context, index) {
          FilmModel film = films![index];
          return ListTile(
            title: Text(film.titre),
            // subtitle: Text(film.synopsis),
            onTap: () {
              showFilmDetails(context, film);
            },
          );
        },
      ),
    );
  }

  // Fonction pour afficher les détails d'un film dans une boîte de dialogue
  void showFilmDetails(BuildContext context, FilmModel film) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(film.titre),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Genre: ${film.genre}'),
            Text('Date de sortie: ${film.dateSortie.toString()}'),
            Text('Réalisateur: ${film.realisateur}'),
            Text('Casting: ${film.casting}'),
            // Text('Synopsis: ${film.synopsis}'),
            Text('Note moyenne: ${film.noteMoyenne.toStringAsFixed(1)}'),
          ],
        ),
        actions: [
          ElevatedButton(
            child: Text('Fermer'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
