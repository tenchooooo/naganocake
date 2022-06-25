# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]
  
  def after_sign_in_path_for(resource)
    customers_my_page_path
  end
  
  protected

  def customer_state
    # 入力されたemailからアカウント一件取得(モデル名：検索する値)
    #  ログイン画面から送られたemailを確認し、Customerモデルに該当するemailのアカウントが存在するかを検索する
    @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する。
    return if !@customer
    # 「1」のアカウントが存在している場合、そのアカウントのパスワードとログイン画面で入力されたパスワードが 一致しているかを確認する
    # Deviseが用意しているメソッド（ユーザー情報.valid_password?(入力されたパスワード)
    if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true && !false)
        redirect_to new_customer_registration_path

    # 「1」と「2」の処理が真(true)だった場合、そのアカウントのis_deletedカラムに格納されている値を確認し
    # trueだった場合、退会しているのでサインアップ画面に遷移する
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
