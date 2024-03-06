class RecipesController < ApplicationController

  def index

    @recipes = current_user.recipes

  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
end
