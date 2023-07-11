import 'package:flutter/material.dart';
import 'package:front/controllers/user_controller.dart';
import 'package:front/models/film_model.dart';
import 'package:front/models/humeurs_model.dart';
import 'package:front/services/humeur_films_service.dart';
import 'package:front/services/humeur_service.dart';
import 'package:front/vues/accueil/film_view.dart';
import 'package:front/vues/accueil/profile_view.dart';

class HumeurView extends StatefulWidget {
  @override
  _HumeurViewState createState() => _HumeurViewState();
}

class _HumeurViewState extends State<HumeurView> {
  List<HumeurModel> humeurs = [];
  List<Color> blockColors = [
    Color(0xFF00B4FD),
    Color(0xFFFFA86E),
    Color(0xFFFF9999),
    Color(0xFF009900),
  ];
  UserController userController =
      UserController.initialize(); // Ajout du contrôleur utilisateur

  @override
  void initState() {
    super.initState();
    fetchHumeurs();
  }

  void fetchHumeurs() async {
    HumeurService humeurService = HumeurService();
    List<HumeurModel> fetchedHumeurs = await humeurService.getAllHumeurs();
    fetchedHumeurs.sort((a, b) => a.nom.compareTo(b.nom));

    setState(() {
      humeurs = fetchedHumeurs;
    });
  }

  void navigateToFilmView(BuildContext context, HumeurModel humeur) async {
    List<FilmModel> films = await humeurFilmService.getFilmsByHumeur(humeur.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilmView(humeur: humeur, films: films),
      ),
    );
  }

  void navigateToProfileView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Liste des Humeurs',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              userController
                  .logout(); // Appel de la méthode logout du contrôleur utilisateur
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: humeurs.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          HumeurModel humeur = humeurs[index];
          Color blockColor = blockColors[index % blockColors.length];

          return GestureDetector(
            onTap: () {
              navigateToFilmView(context, humeur);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: blockColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  humeur.nom.toUpperCase(),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Naviguer vers la vue Accueil
                // TODO: Implémentez votre logique ici
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                navigateToProfileView(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
