module SessionsHelper

	def sign_in(user)
		# 1. トークンを新規作成する
		remember_token = User.new_remember_token
		# 2. 暗号化されていないトークンをブラウザのcookieに保存する
		cookies.permanent[:remember_token] = remember_token
		# 3. 暗号化したトークンをデータベースに保存する
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		# 4. 与えられたユーザを現在のユーザに指定する
		self.current_user = user
	end

	def  signed_in?
		!current_user.nil?
	end

	def current_user=(user) # current_userへの要素代入を扱うように設計されている
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
		# ||= ... or equals @current_userが未定義の場合にのみ、@current_userインスタンス変数に記憶トークンを設定する
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
  end

	def  sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end
end
