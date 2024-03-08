class AregistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(account_update_params)
      set_flash_message :notice, :updated
      sign_in resource_name, resource, bypass: true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def account_update_params
    params.require(:user).permit(:age, :sex, :height, :weight, :activity, :goal, :current_password)
  end
end
