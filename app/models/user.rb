class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birthdate, presence: true
  validates :password,
            format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,}\z/, message: 'は半角英字と半角数字の両方を含めてください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
end
