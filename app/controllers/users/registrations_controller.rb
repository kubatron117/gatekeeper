class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: :update

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :avatar,
      address_attributes: [
        :id,
        :street_name,
        :street_number,
        :city,
        :postal_code,
        :country_name,
        :_destroy
      ]
    ])
  end
end
