# frozen_string_literal: true

json.data @recipes do |recipe|
  json.call(recipe, :id, :title, :image, :rating, :cook_time, :prep_time, :cuisine,
            :category, :author)

  json.recipe_ingredients recipe.recipe_ingredients do |recipe_ingredient|
    json.call(recipe_ingredient, :id, :title)
  end
end
