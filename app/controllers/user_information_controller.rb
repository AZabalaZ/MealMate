class UserInformationController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
    @gasto_calorico = @user.gasto_calorico
    @requerimientos = @user.requerimientos
  end
end
