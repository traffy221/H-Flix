import { useState } from "react";
import { Container, Navbar, Row, Col } from "react-bootstrap";
import {AddFilm} from "../component";
import {FilmList} from "../component";
import "./style.vues.css";

const FilmView = () => {
  const [filmId, setFilmId] = useState("");

  const getFilmIdHandler = (id) => {
    console.log("L'ID du document à modifier : ", id);
    setFilmId(id);
  };

  return (
    <>
      <Navbar bg="dark" variant="dark" className="header">
        <Container>
          <Navbar.Brand href="#home">Bibliothèque de films - CRUD Firebase</Navbar.Brand>
        </Container>
      </Navbar>

      <Container style={{ width: "400px" }}>
        <Row>
          <Col>
            <AddFilm id={filmId} setFilmId={setFilmId} />
          </Col>
        </Row>
      </Container>

      <Container>
        <Row>
          <Col>
            <FilmList getFilmId={getFilmIdHandler} />
          </Col>
        </Row>
      </Container>
    </>
  );
};

export default FilmView;
