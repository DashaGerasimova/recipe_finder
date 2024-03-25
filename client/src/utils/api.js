const BASE_URL = process.env.API_BASE_URL || 'http://localhost:3000';

export async function fetchRecipes(ingredients, page = 1) {
  const ingredientsQuery = ingredients.map(ingredient => `ingredients[]=${encodeURIComponent(ingredient)}`).join('&');
  const response = await fetch(`${BASE_URL}/api/recipes?${ingredientsQuery}&page=${page}`);
  if (response.ok) {
    const data = await response.json();
    return data.data;
  } else {
    throw new Error('Failed to fetch recipes');
  }
}

export async function fetchAutocomplete(value) {
  const response = await fetch(`${BASE_URL}/api/ingredients/autocomplete?q=${value}`);
  if (response.ok) {
    const data = await response.json();
    return data.data;
  } else {
    throw new Error('Failed to fetch ingredients');
  }
}
