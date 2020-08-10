class Board < ApplicationRecord
    acts_as_paranoid
  
    has_many :posts
  
    has_many :board_masters
    has_many :users, through: :board_masters
  
    has_many :favorite_boards
    has_many :favorited_users, through: :favorite_boards, source: :user
  
    validates :title, presence: true, length: { minimum: 2 }

    def favorited_by?(user)
      favorited_users.include?(user)
      # 這個看板的喜歡者有沒有包含你
    end
  end
  