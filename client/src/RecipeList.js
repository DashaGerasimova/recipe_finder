// RecipeList.js
import React, { useState, useEffect } from 'react';
import './RecipeList.css';
import { fetchRecipes } from "./utils/api";

function RecipeList({ ingredients }) {
  const [recipes, setRecipes] = useState([]);
  const [page, setPage] = useState(1);

  useEffect(() => {
    setPage(1)
    initRecipes();
  }, [ingredients]);

  const initRecipes = async () => {
    try {
      const fetchedRecipes = await fetchRecipes(ingredients);
      setRecipes(fetchedRecipes);
    } catch (error) {
      console.error('Error:', error);
    }
  };

  const loadNext = async () => {
    setPage((prevPage) => prevPage + 1);

    try {
      const fetchedRecipes = await fetchRecipes(ingredients, page);
      setRecipes((prevRecipes) => [...prevRecipes, ...fetchedRecipes]);
    } catch (error) {
      console.error('Error:', error);
    }
  }

  window.onscroll = () => {
    if (
      window.innerHeight + document.documentElement.scrollTop ===
      document.documentElement.offsetHeight
    ) {
      loadNext();
    }
  };

  return (
    <div className="recipe-list-container">
      <h2>Recipes</h2>
      <div className="recipes">
        {recipes.map((recipe, index) => (
          <div key={index} className="recipe-card">
            <div className="recipe-image">
              <img src={recipe.image} alt={recipe.title} />
            </div>
            <div className="recipe-details">
              <h3>{recipe.title}</h3>
              <p><strong>Rating:</strong> {recipe.rating}</p>
              <p><strong>Author:</strong> {recipe.author}</p>
              <p><strong>Category:</strong> {recipe.category}</p>
              <p><strong>Cook Time:</strong> {recipe.cook_time} minutes</p>
              <p><strong>Prep Time:</strong> {recipe.prep_time} minutes</p>
              <div>
                <strong>Ingredients:</strong>
                <ul>
                  {recipe.recipe_ingredients.map((ingredient, index) => (
                    <li key={index}>{ingredient.title}</li>
                  ))}
                </ul>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}


export default RecipeList;
