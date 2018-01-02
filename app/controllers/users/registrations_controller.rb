class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    user_email = current_user.email.split('@').first
    url = "#{user_email}#{rand(10**10).to_s.rjust(10, '0')}"
    default = { url: url, theme: 'default',
                color_one: '#0a0d72', color_two: '#83c9f4',
                color_three: '#2196f3', color_four: '#00a6fb',
                font_color_one: '#ffffff', font_color_two: '#ffffff',
                show_cover_image: false, show_avatar_image: true,
                show_years_exp: true, show_proficiency: true }
    portfolio = current_user.portfolios.create(default)
    current_user.update_attribute(:options, active_portfolio_id: portfolio.id)
    current_user.save
    root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
