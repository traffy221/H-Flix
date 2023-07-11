import React, { useState } from "react";
import { Form, Alert, InputGroup, Button } from "react-bootstrap";
import { HumeurService } from "../services";

const humeurService = new HumeurService();

export const AddHumeur = () => {
  const [nom, setNom] = useState("");
  const [films, setFilms] = useState([]);
  const [message, setMessage] = useState({ error: false, msg: "" });

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");
    if (nom === "") {
      setMessage({ error: true, msg: "Le nom de l'humeur est obligatoire !" });
      return;
    }
    const nouvelleHumeur = {
      nom,
      films,
    };

    try {
      await humeurService.addHumeur(nouvelleHumeur);
      setMessage({ error: false, msg: "Nouvelle humeur ajoutée avec succès !" });
      setNom("");
      setFilms([]);
    } catch (err) {
      setMessage({ error: true, msg: err.message });
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
            <InputGroup>
              <InputGroup.Text id="formFilmsHumeur">Films</InputGroup.Text>
              <Form.Control
                type="text"
                placeholder="Liste des films"
                value={films}
                onChange={(e) => setFilms(e.target.value)}
              />
            </InputGroup>
          </Form.Group>

          <div className="d-grid gap-2">
            <Button variant="primary" type="submit">
              Ajouter
            </Button>
          </div>
        </Form>
      </div>
    </>
  );
};
