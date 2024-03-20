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
    @ingredient = current_user.ingredients.build(ingredient_params)  # Asocia el nuevo ingrediente con el usuario actual
    if @ingredient.save
      render json: { message: 'Ingredient created successfully' }, status: :created
    else
      render json: { message: 'Ingredient not created' }, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    redirect_to my_ingredients_path, notice: "Ingrediente eliminado correctamente."
  end

  def my_ingredients
    @my_ingredients = current_user.ingredients
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :calories, :proteins)
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
