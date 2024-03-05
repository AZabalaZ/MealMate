class MealsController < ApplicationController

  def index
    @meals = Meal.all
  end

  def foods
    @foods = Meal.all
  end
end
