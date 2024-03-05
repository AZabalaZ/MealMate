class MealsController < ApplicationController
  
  def index
    @meals = Meal.all
    
  def foods
    @foods = Meal.all
  end
end
