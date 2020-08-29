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


    include AASM

    # 狀態機，制定規則
    aasm(column: 'state') do
      state :normal, initial: true
      state :hidden, :locked
  
      event :hide do
        transitions from: [:normal, :locked], to: :hidden
      end
  
      event :show do
        transitions from: :hidden, to: :locked
      end
  
      event :lock do
        transitions from: [:normal, :hidden], to: :locked

      end
  
      event :unlock do
        transitions from: :locked, to: :normal
      end
    end
end
  