import React, { useState, useEffect } from "react";
import { Form, Alert, InputGroup, Button } from "react-bootstrap";
import { HumeurService, FilmService } from "../services";

const humeurService = new HumeurService();
const filmService = new FilmService();

const HumeurView = ({ id }) => {
  const [nom, setNom] = useState("");
  const [films, setFilms] = useState([]);
  const [selectedFilms, setSelectedFilms] = useState([]);
  const [message, setMessage] = useState({ error: false, msg: "" });

  useEffect(() => {
    const fetchHumeur = async () => {
      try {
        const humeurSnap = await humeurService.getHumeur(id);
        const humeurData = humeurSnap.data;
        setNom(humeurData.nom);
        setSelectedFilms(humeurData.films);
      } catch (error) {
        setMessage({ error: true, msg: error.message });
      }
    };

    fetchHumeur();
  }, [id]);

  useEffect(() => {
    const fetchFilms = async () => {
      try {
        const filmsSnap = await filmService.getAllFilms();
        const filmsData = filmsSnap.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setFilms(filmsData);
      } catch (error) {
        setMessage({ error: true, msg: error.message });
      }
    };

    fetchFilms();
  }, []);

  const handleFilmSelection = (filmId) => {
    if (selectedFilms.includes(filmId)) {
      setSelectedFilms(selectedFilms.filter((id) => id !== filmId));
    } else {
      setSelectedFilms([...selectedFilms, filmId]);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");

    if (nom === "") {
      setMessage({ error: true, msg: "Veuillez fournir un nom d'humeur." });
      return;
    }

    const updatedHumeur = {
      nom,
      films: selectedFilms,
    };

    try {
      await humeurService.addHumeur(updatedHumeur);
      setMessage({ error: false, msg: "Humeur mise à jour avec succès !" });
    } catch (error) {
      setMessage({ error: true, msg: error.message });
    }
  };

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
          <Form.Group className="mb-3" controlId="formNomHumeur">
            <InputGroup>
              <InputGroup.Text id="formNomHumeur">Nom</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Nom de l'humeur"
                value={nom}
                onChange={(e) => setNom(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <Form.Group className="mb-3" controlId="formFilmsHumeur">
            <Form.Label>Films</Form.Label>
            {films.map((film) => (
              <Form.Check
                key={film.id}
                type="checkbox"
                id={film.id}
                label={film.titre}
                checked={selectedFilms.includes(film.id)}
                onChange={() => handleFilmSelection(film.id)}
              />
            ))}
          </Form.Group>

          <div className="d-grid gap-2">
            <Button variant="primary" type="submit">
              Enregistrer
            </Button>
          </div>
        </Form>
      </div>
    </>
  );
};

export default HumeurView;