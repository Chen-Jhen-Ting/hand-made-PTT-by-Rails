class Post < ApplicationRecord
  belongs_to :board
  # 這一段產生了 board  board= 方法給 Post 用
  validates :title, presence: true, length: {minimum: 2}
end
