class User < ActiveRecord::Base
	has_secure_password
	# email属性を小文字に変換してメールアドレスの一意性を保証する
	# データを保存する前にアドレスを小文字に変換する
	before_save { email.downcase! }
	validates :name, presence: true,length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true,
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false} # case_sensitive...大文字と小文字を区別する
	validates :password, length: { minimum: 6 }
end
