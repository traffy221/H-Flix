import { db } from "../config/firebase.config";
import {
  collection,
  getDocs,
  getDoc,
  addDoc,
  updateDoc,
  deleteDoc,
  doc,
} from "firebase/firestore";

const filmCollectionRef = collection(db, "films");

export class FilmService {
  // Ajouter un film
  addFilm(newFilm) {
    return addDoc(filmCollectionRef, newFilm)
      .then((docRef) => docRef.id) // Renvoie l'ID du document ajouté
      .catch((error) => {
        throw new Error("Erreur lors de l'ajout du film : " + error.message);
      });
  }

  // Mettre à jour un film
  updateFilm(id, updatedFilm) {
    const filmDoc = doc(db, "films", id);
    return updateDoc(filmDoc, updatedFilm);
  }

  // Supprimer un film
  deleteFilm(id) {
    const filmDoc = doc(db, "films", id);
    return deleteDoc(filmDoc);
  }

  // Obtenir tous les films
  getAllFilms() {
    return getDocs(filmCollectionRef);
  }

  // Obtenir un film spécifique
  getFilm(id) {
    const filmDoc = doc(db, "films", id);
    return getDoc(filmDoc);
  }
}
