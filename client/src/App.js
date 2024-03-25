import './App.css';
import React, { useState } from 'react';
import SearchBar from './SearchBar';
import RecipeList from './RecipeList';

function App() {
  const [ingredients, setIngredients] = useState([]);

  const handleSearch = async (ingredients) => {
    setIngredients(ingredients)
  };


  return (
    <div className="App">
      <SearchBar onSearch={handleSearch} />
      <RecipeList ingredients={ingredients} />
    </div>
  );
}

export default App;
