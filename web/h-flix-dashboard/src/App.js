import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import FilmView from './vues/film.vues';
import HumeurView from './vues/humeur.vues';

function App() {
  return (
    <Router>
      <Routes>
        <Route exact path='/' element={<FilmView/>} />
        <Route path='/humeur' element={<HumeurView/>} />
      </Routes>
    </Router>
  );
}

export default App;
