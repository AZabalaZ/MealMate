# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Ingredient.create(name: "chicken", calories: 200)
Ingredient.create(name: "beef", calories: 300)
Ingredient.create(name: "pork", calories: 250)
Ingredient.create(name: "rice", calories: 150)
Ingredient.create(name: "beans", calories: 100)
Ingredient.create(name: "potatoes", calories: 200)
Ingredient.create(name: "carrots", calories: 50)
Ingredient.create(name: "peas", calories: 50)
Ingredient.create(name: "corn", calories: 50)
Ingredient.create(name: "broccoli", calories: 50)
Ingredient.create(name: "spinach", calories: 50)
Ingredient.create(name: "lettuce", calories: 50)
Ingredient.create(name: "tomatoes", calories: 50)
Ingredient.create(name: "onions", calories: 50)
Ingredient.create(name: "garlic", calories: 50)
Ingredient.create(name: "olive oil", calories: 100)
Ingredient.create(name: "butter", calories: 100)
Ingredient.create(name: "milk", calories: 100)
Ingredient.create(name: "cheese", calories: 100)
Ingredient.create(name: "eggs", calories: 100)
Ingredient.create(name: "flour", calories: 100)

Meal.create(name: "chicken and rice", description: "grilled chicken with rice", calories: 350, favorite: true, calories_sum: 350)
Meal.create(name: "beef and potatoes", description: "grilled beef with potatoes", calories: 400, favorite: true, calories_sum: 400)
Meal.create(name: "pork and beans", description: "grilled pork with beans", calories: 350, favorite: true, calories_sum: 350)
Meal.create(name: "vegetable stir fry", description: "mixed vegetables stir fried", calories: 200, favorite: true, calories_sum: 200)
