import React, { useEffect, useState } from "react";
import { Table, Button } from "react-bootstrap";
import {HumeurService} from "../services";

export const HumeurList = ({ getHumeurId }) => {
  const [humeurs, setHumeurs] = useState([]);

  useEffect(() => {
    // Appel de la fonction pour récupérer les humeurs au chargement initial du composant
    getHumeurs();
  }, []);

  const getHumeurs = async () => {
    // Récupération des données de toutes les humeurs à partir du service HumeurService
    const data = await HumeurService.getAllHumeurs();
    console.log(data.docs);
    // Mise à jour de l'état humeurs avec les données récupérées
    setHumeurs(data.docs.map((doc) => ({ ...doc.data(), id: doc.id })));
  };

  const deleteHandler = async (id) => {
    // Appel de la fonction pour supprimer une humeur en utilisant son ID
    await HumeurService.deleteHumeur(id);
    // Récupération des humeurs à jour après la suppression
    getHumeurs();
  };

  return (
    <>
      <div className="mb-2">
        <Button variant="dark edit" onClick={getHumeurs}>
          Rafraîchir la liste
        </Button>
      </div>

      <Table striped bordered hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>ID</th>
            <th>Nom de l'humeur</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {humeurs.map((doc, index) => {
            return (
              <tr key={doc.id}>
                <td>{index + 1}</td>
                <td>{doc.id}</td>
                <td>{doc.nom}</td>
                <td>
                  <Button
                    variant="secondary"
                    className="edit"
                    onClick={(e) => getHumeurId(doc.id)}
                  >
                    Modifier
                  </Button>
                  <Button
                    variant="danger"
                    className="delete"
                    onClick={(e) => deleteHandler(doc.id)}
                  >
                    Supprimer
                  </Button>
                </td>
              </tr>
            );
          })}
        </tbody>
      </Table>
    </>
  );
};


