class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.accessible_by(current_ability).page(params[:page])
  end

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
    @user.build_address if @user.address.nil?
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Uživatel byl úspěšně aktualizován."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_path, notice: "Uživatel byl smazán.", status: :see_other
  end

  private

  def set_user
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      :password, :password_confirmation,
      :avatar,
      :role,
      address_attributes: %i[
        id
        street_name
        street_number
        city
        postal_code
        country_name
        _destroy
      ]
    )
  end
end
