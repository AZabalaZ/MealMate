class IngredientsController < ApplicationController
  def index
    if params[:search]
    @ingredients = Ingredient.where('name LIKE ?', "%#{params[:search]}%")
    else
    @ingredients = []
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'ingredients/list', locals: { ingredients: @ingredients }, formats: [:html] }
    end
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      render json: { message: 'Ingredient created successfully' }, status: :created
    else
      render json: { message: 'Ingredient not created' }, status: :unprocessable_entity
    end
  end

  def my_ingredients
    @my_ingredients = Ingredient.all
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :calories)
  end
end

# class PagesController < ApplicationController
#   skip_before_action :authenticate_user!, only: [ :home ]

#   require 'rest-client'

#   def home
#     url = "https://api.edamam.com/api/food-database/v2/parser?app_id=3355767f&app_key=2d3e7448b4e10b30ae472b4ef12dd0c0&ingr=tomato&nutrition-type=cooking"
#     response = RestClient.get(url)
#     data = JSON.parse(response.body)

#     data['hints'].each do |datum|
#       pp datum['food']['label']
#       pp datum['food']['nutrients']['ENERC_KCAL']
#       pp datum['food']['image']
#       pp '-' * 50
#     end
#   end
# end
