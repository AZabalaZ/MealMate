class UserInformationController < ApplicationController

  before_action :authenticate_user! # Asegura que el usuario esté autenticado antes de acceder a la información

  def show
    @user = current_user
    @gasto_calorico = @user.gasto_calorico
    @requerimientos = @user.requerimientos
  end
end
