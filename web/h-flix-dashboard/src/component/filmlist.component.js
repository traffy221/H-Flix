import React, { useEffect, useState } from "react";
import { Table, Button } from "react-bootstrap";
import {FilmService} from "../services";

export const FilmList = ({ getFilmId }) => {
  const [films, setFilms] = useState([]);

  useEffect(() => {
    getFilms();
  }, []);

  const getFilms = async () => {
    const data = await FilmService.getAllFilms();
    console.log(data.docs);
    setFilms(data.docs.map((doc) => ({ ...doc.data(), id: doc.id })));
  };

  const deleteHandler = async (id) => {
    await FilmService.deleteFilm(id);
    getFilms();
  };

  return (
    <>
      <div className="mb-2">
        <Button variant="dark edit" onClick={getFilms}>
          Rafraîchir la liste
        </Button>
      </div>

      <Table striped bordered hover size="sm">
        <thead>
          <tr>
            <th>#</th>
            <th>Titre du film</th>
            <th>Genre</th>
            <th>Date de sortie</th>
            <th>Réalisateur</th>
            <th>Casting</th>
            <th>Note moyenne</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {films.map((doc, index) => {
            return (
              <tr key={doc.id}>
                <td>{index + 1}</td>
                <td>{doc.titre}</td>
                <td>{doc.genre}</td>
                <td>{doc.dateSortie}</td>
                <td>{doc.realisateur}</td>
                <td>{doc.casting}</td>
                <td>{doc.noteMoyenne}</td>
                <td>
                  <Button
                    variant="secondary"
                    className="edit"
                    onClick={(e) => getFilmId(doc.id)}
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

