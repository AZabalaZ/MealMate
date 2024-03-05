class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def foods
    @foods = Meal.all
  end

  def add_to_my_recipes

    meal = Meal.find(params[:id])
    Recipe.new(meal: meal, user: current_user).save
    redirect_to meals_path, notice: "Recipe added to My recipes"
  end
end
