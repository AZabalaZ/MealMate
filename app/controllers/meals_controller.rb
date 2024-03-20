class MealsController < ApplicationController
  before_action :authenticate_user!

  def index
    @meals = current_user.meals
  end


  # def foods
  #   @foods = Meal.all
  # end

  def favorites
    @favorite_meals = current_user.recipes.select(&:favorite).map(&:meal)
  end

  def create
    if current_user.present?
      begin
        @meal = current_user.meals.build(meal_params) # Asocia la nueva comida con el usuario actual
        if @meal.save
          render json: @meal, status: :created
        else
          render json: @meal.errors, status: :unprocessable_entity
        end
      rescue => e
        render json: { error: "An error occurred while creating the meal: #{e.message}" }, status: :internal_server_error
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end


  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    redirect_to meals_path
  end

  def view_recipe
    @meal = Meal.find(params[:id])
    @recipe_steps = @meal.description
  end

  def add_to_my_recipes
    meal = Meal.find(params[:id])
    Recipe.create(meal: meal, user: current_user, favorite: false)
    redirect_to meals_path, notice: "Recipe added to My recipes"
  end

  def add_to_favorites
    meal = Meal.find(params[:id])
    # current_user.favorite_meals << meal
    Recipe.create(meal: meal, user: current_user, favorite: true)
    redirect_to meals_path, notice: "Recipe added to favorites"
  end

  def remove_from_favorites
    meal = Meal.find(params[:id])
    # current_user.favorite_meals.delete(meal)
    recipe = Recipe.find_by(meal: meal)
    recipe.destroy
    redirect_to favorites_path, notice: "Recipe removed from favorites"
  end

private

  def meal_params
    params.require(:meal).permit(:name, :description, :calories, :image_url, :calories_sum, :portion, :preparation_time, :proteins)
  end
end
