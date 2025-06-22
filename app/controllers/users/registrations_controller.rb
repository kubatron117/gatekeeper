class Users::RegistrationsController < Devise::RegistrationsController
  before_action :build_delete_resource, only: [:edit, :update, :destroy]
  before_action :configure_account_update_params, only: :update

  def edit
    super
  end

  def update
    if params[resource_name]&.dig(:address_attributes, :_destroy) == "1" && resource.address
      resource.address.destroy
      params[resource_name].delete(:address_attributes)
    end

    super
  end

  def destroy
    if account_delete_params[:current_password].blank?
      @delete_user.errors.add(:current_password, :blank)
      return respond_with @delete_user, action: :edit
    end

    unless resource.valid_password?(account_delete_params[:current_password])
      @delete_user.errors.add(:current_password, :invalid)
      return respond_with @delete_user, action: :edit
    end

    if resource.tasks.exists?
      @delete_user.errors.add(:base, "You have existing tasks and cannot delete your account.")
      return respond_with @delete_user, action: :edit
    end

    super
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :avatar,
      address_attributes: [
        :id, :street_name, :street_number,
        :city, :postal_code, :country_name,
        :_destroy
      ]
    ])
  end

  def account_delete_params
    params.require(resource_name).permit(:current_password)
  end

  def build_delete_resource
    @delete_user = resource_class.new
    @delete_user.id = resource.id
  end
end
