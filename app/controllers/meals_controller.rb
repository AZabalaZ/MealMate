class MealsController < ApplicationController
  def foods
    @foods = Meal.all
  end
end
