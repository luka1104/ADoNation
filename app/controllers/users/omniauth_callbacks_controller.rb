class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def twitter
    callback_from(:twitter)
  end

  def google_oauth2
    callback_for(:google)
  end

  # def facebook
  #   if request.env['omniauth.auth'].info.email.blank?
  #     redirect_to '/users/auth/facebook?auth_type=rerequest&scope=email'
  #   end

  #   # User.from_omniauthはModel側で実装
  #   user = User.from_omniauth(request.env['omniauth.auth'])

  #   # すでにuserが登録済みかの判定
  #   if user
  #     # 登録済みならログイン
  #     sign_in_and_redirect user, event: :authentication
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     # 新規登録用にセッションに必要情報を格納
  #     if (data = request.env['omniauth.auth'])
  #       session['devise.omniauth_data'] = {
  #           email: data['info']['email'],
  #           provider: data['provider'],
  #           uid: data['uid']
  #       }
  #     end
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def failure
  #   redirect_to root_path
  # end

  # def twitter
  #   user = User.from_omniauth(request.env['omniauth.auth'])
  #   if user
  #     sign_in_and_redirect user, event: :authentication
  #     set_flash_message(:notice, "Twitter") if is_navigational_format?
  #   else
  #     if (data = request.env['omniauth.auth'])
  #       session['devise.omniauth_data'] = {
  #           email: data['info']['email'],
  #           provider: data['provider'],
  #           uid: data['uid']
  #       }
  #     end
  #     redirect_to new_user_registration_url
  #   end
  # end
  # common callback method
  # def callback_for(provider)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #   else
  #     session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def failure
  #   redirect_to root_path
  # end
  # 最後のendの直前に記載
  private

  # コールバック時に行う処理
  def callback_from(provider)
    provider = provider.to_s

    @user = User.from_omniauth(request.env['omniauth.auth'])

    # persisted?でDBに保存済みかどうか判断
    if @user.persisted?
      # サインアップ時に行いたい処理があればここに書きます。
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end