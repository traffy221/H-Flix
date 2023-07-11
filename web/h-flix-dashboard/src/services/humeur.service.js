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

const humeurCollectionRef = collection(db, "humeurs");

export class HumeurService {
  // Ajouter une humeur avec des films associés
  async addHumeur(newHumeur) {
    const docRef = await addDoc(humeurCollectionRef, newHumeur);
    return docRef.id;
  }

  // Mettre à jour une humeur avec des films associés
  async updateHumeur(id, updatedHumeur) {
    const humeurDoc = doc(humeurCollectionRef, id);
    await updateDoc(humeurDoc, updatedHumeur);
  }

  // Supprimer une humeur avec des films associés
  async deleteHumeur(id) {
    const humeurDoc = doc(humeurCollectionRef, id);
    await deleteDoc(humeurDoc);
  }

  // Obtenir toutes les humeurs avec les films associés
  async getAllHumeurs() {
    const querySnapshot = await getDocs(humeurCollectionRef);
    const humeurs = [];
    querySnapshot.forEach((doc) => {
      const humeur = doc.data();
      humeur.id = doc.id;
      humeurs.push(humeur);
    });
    return humeurs;
  }

  // Obtenir une humeur spécifique avec les films associés
  async getHumeur(id) {
    const humeurDoc = doc(humeurCollectionRef, id);
    const docSnapshot = await getDoc(humeurDoc);
    if (docSnapshot.exists()) {
      const humeur = docSnapshot.data();
      humeur.id = docSnapshot.id;
      return humeur;
    } else {
      throw new Error("Humeur non trouvée");
    }
  }
}
