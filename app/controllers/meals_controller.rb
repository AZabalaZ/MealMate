class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def foods
    @foods = Meal.all
  end

  def favorites
    @favorite_meals = current_user.recipes.map(&:meal)
  end

  def add_to_my_recipes
    meal = Meal.find(params[:id])
    Recipe.new(meal: meal, user: current_user).save
    redirect_to meals_path, notice: "Recipe added to My recipes"
  end

  def add_to_favorites
    meal = Meal.find(params[:id])
    current_user.favorite_meals << meal
    redirect_to meals_path, notice: "Recipe added to favorites"
  end

  def remove_from_favorites
    meal = Meal.find(params[:id])
    current_user.favorite_meals.delete(meal)
    redirect_to meals_path, notice: "Recipe removed from favorites"
  end
end
