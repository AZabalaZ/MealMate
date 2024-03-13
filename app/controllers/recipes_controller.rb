class RecipesController < ApplicationController

  def index
    @recipes = current_user.recipes.reject(&:favorite)
    @total_calories = @recipes.sum { |recipe| recipe.meal.calories.to_i }
    @total_proteins = @recipes.sum { |recipe| recipe.meal.proteins.to_i }
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def create

    meal = Meal.find(params[:meal_id])

    current_user.recipes.create(meal: meal)
    redirect_to recipes_path, notice: "¡La comida ha sido agregada a Mis Recipes!"
  end
end
