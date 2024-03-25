# frozen_string_literal: true

namespace :import_data do
  desc 'Import recipes.json to database'
  task execute: :environment do
    file = File.open('public/recipes-en.json').read
    recipes_json = JSON.parse file

    MEASUREMENT_WORDS = [
      'cup',
      'cups',
      'teaspoon',
      'teaspoons',
      'tablespoon',
      'tablespoons',
      'pint',
      'pints',
      'quart',
      'quarts',
      'ounce',
      'ounces',
      'fluid ounce',
      'fluid ounces',
      'pound',
      'pounds',
      'gram',
      'grams',
      'kilogram',
      'kilograms',
      'milliliter',
      'milliliters',
      'liter',
      'liters',
      'gallon',
      'gallons',
      'milligram',
      'milligrams',
      'dash',
      'dashes',
      'pinch',
      'pinches',
      'drop',
      'drops',
      'handful',
      'handfuls',
      'slice',
      'slices',
      'piece',
      'pieces',
      'bulb',
      'bulbs',
      'bunch',
      'bunches',
      'sprig',
      'sprigs',
      'stick',
      'sticks',
      'package',
      'packages',
      'packed',
      'can',
      'cans',
      'jar'
    ].freeze

    DESCRIPTION_WORDS = [
      'minced',
      'chopped',
      'diced',
      'sliced',
      'grated',
      'shredded',
      'peeled',
      'cored',
      'seeded',
      'pitted',
      'crushed',
      'pureed',
      'mashed',
      'sifted',
      'drained',
      'rinsed',
      'soaked',
      'marinated',
      'cooked',
      'baked',
      'roasted',
      'boiled',
      'steamed',
      'grilled',
      'fried',
      'sauteed',
      'stir-fried',
      'braised',
      'poached',
      'blanched',
      'caramelized',
      'glazed',
      'toasted',
      'seasoned',
      'flavored',
      'spiced',
      'herbed',
      'salted',
      'peppered',
      'seasoned',
      'seasoning',
      'flavored',
      'dried',
      'fresh',
      'freshly',
      'frozen',
      'thawed',
      'room temperature',
      'refrigerated',
      'melted',
      'ripe',
      'fine',
      'finely'
    ].freeze

    EXTRA_DESCRIPTION = [
      'or more.*',
      'or as.*',
      'or to.*',
      'or other.*',
      'or extra.*',
      'plus.*',
      'cut in.*',
      'broken into.*',
      'torn into.*',
      'or',
      'and',
      'at'
    ].freeze

    ingredient_regexp = /\b(#{(EXTRA_DESCRIPTION + MEASUREMENT_WORDS + DESCRIPTION_WORDS).join('|')})\b\s*/

    recipes_json.each do |recipe_json|
      recipe = Recipe.create(
        title: recipe_json['title'],
        cook_time: recipe_json['cook_time'],
        prep_time: recipe_json['prep_time'],
        rating: recipe_json['ratings'],
        cuisine: recipe_json['cuisine'],
        category: recipe_json['category'],
        author: recipe_json['author'],
        image: recipe_json['image']
      )

      pure_ingredients = recipe_json['ingredients'].map do |ingredient_json|
        pure_ingredient_name = ingredient_json.gsub(/\((.*?)\)/, '')
                                              .gsub(/[^\w\s]+/, '')
                                              .gsub(/\d+/, '')
                                              .gsub(ingredient_regexp, '')
                                              .strip

        ingredient = Ingredient.where(title: pure_ingredient_name).first_or_create

        RecipeIngredient.create(title: ingredient_json, ingredient:, recipe:) if ingredient.persisted?

        pure_ingredient_name
      end

      recipe.update(raw_ingredients: pure_ingredients.join(' '))
    end
  end
end
