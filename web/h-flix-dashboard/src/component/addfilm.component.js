import React, { useState, useEffect } from "react";
import { Form, Alert, InputGroup, Button, ButtonGroup } from "react-bootstrap";
import {FilmService} from "../services";

const filmservice = new FilmService();

export const AddFilm = ({ id, setFilmId }) => {
  const [titre, setTitre] = useState("");
  const [genre, setGenre] = useState("");
  const [dateSortie, setDateSortie] = useState("");
  const [realisateur, setRealisateur] = useState("");
  const [casting, setCasting] = useState("");
  const [noteMoyenne, setNoteMoyenne] = useState(0);
  const [message, setMessage] = useState({ error: false, msg: "" });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");
    if (titre === "" || genre === "" || dateSortie === "" || realisateur === "") {
      setMessage({ error: true, msg: "Tous les champs sont obligatoires !" });
      return;
    }
    const nouveauFilm = {
      titre,
      genre,
      dateSortie,
      realisateur,
      casting,
      noteMoyenne,
    };

    try {
      if (id !== undefined && id !== "") {
        await filmservice.updateFilm(id, nouveauFilm);
        setFilmId("");
        setMessage({ error: false, msg: "Film mis à jour avec succès !" });
      } else {
        await filmservice.addFilm(nouveauFilm);
        setMessage({ error: false, msg: "Nouveau film ajouté avec succès !" });
      }
    } catch (err) {
      setMessage({ error: true, msg: err.message });
    }

    setTitre("");
    setGenre("");
    setDateSortie("");
    setRealisateur("");
    setCasting("");
    setNoteMoyenne(0);
  };

  const editHandler = async () => {
    setMessage("");
    try {
      const docSnap = await filmservice.getFilm(id);
      console.log("L'enregistrement est :", docSnap.data());
      const donneesFilm = docSnap.data();
      setTitre(donneesFilm.titre);
      setGenre(donneesFilm.genre);
      setDateSortie(donneesFilm.dateSortie);
      setRealisateur(donneesFilm.realisateur);
      setCasting(donneesFilm.casting);
      setNoteMoyenne(donneesFilm.noteMoyenne);
    } catch (err) {
      setMessage({ error: true, msg: err.message });
    }
  };

  useEffect(() => {
    console.log("L'ID ici est : ", id);
    if (id !== undefined && id !== "") {
      editHandler();
    }
  }, [id]);

  return (
    <>
      <div className="p-4 box">
        {message?.msg && (
          <Alert
            variant={message?.error ? "danger" : "success"}
            dismissible
            onClose={() => setMessage("")}
          >
            {message?.msg}
          </Alert>
        )}

        <Form onSubmit={handleSubmit}>
          <Form.Group className="mb-3" controlId="formTitreFilm">
            <InputGroup>
              <InputGroup.Text id="formTitreFilm">T</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Titre du film"
                value={titre}
                onChange={(e) => setTitre(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formGenreFilm">
            <InputGroup>
            <InputGroup.Text id="formGenreFilm">G</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Genre du film"
                value={genre}
                onChange={(e) => setGenre(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formDateSortieFilm">
            <InputGroup>
              <InputGroup.Text id="formDateSortieFilm">D</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Date de sortie du film"
                value={dateSortie}
                onChange={(e) => setDateSortie(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formRealisateurFilm">
            <InputGroup>
              <InputGroup.Text id="formRealisateurFilm">R</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Réalisateur du film"
                value={realisateur}
                onChange={(e) => setRealisateur(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formCastingFilm">
            <InputGroup>
              <InputGroup.Text id="formCastingFilm">C</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Casting du film"
                value={casting}
                onChange={(e) => setCasting(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formNoteMoyenneFilm">
            <InputGroup>
              <InputGroup.Text id="formNoteMoyenneFilm">N</InputGroup.Text>
              <Form.Control
                type="number"
                placeholder="Note moyenne du film"
                value={noteMoyenne}
                onChange={(e) => setNoteMoyenne(parseFloat(e.target.value))}
              />
            </InputGroup>
          </Form.Group>

          <div className="d-grid gap-2">
            <Button variant="primary" type="Submit">
              Ajouter/Mettre à jour
            </Button>
          </div>
        </Form>
      </div>
    </>
  );
};


