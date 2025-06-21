class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:new, :create, :destroy]
  before_action :build_address, only: [:edit]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def authorize_admin
    return if current_user&.admin?

    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def build_address
    resource.build_address unless resource.address
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [
      :password, :password_confirmation, :avatar,
      address_attributes: [:street_name, :street_number, :city, :postal_code, :country_name, :id]
    ])
  end
end
