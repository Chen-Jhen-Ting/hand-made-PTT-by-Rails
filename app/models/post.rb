class Post < ApplicationRecord

  validates :title, presence: true, length: {minimum: 2}
  validates :serial, uniqueness: true

  
  acts_as_paranoid
  
  belongs_to :board
  # 這一段產生了 board  board= 方法給 Post 用

  belongs_to :user
  has_many :comments
  has_many :user, through: :comments


  before_create :create_serial

  def display_username
    if user.nil? 
      "-"
    else
      user.account
    end
  end

  private

  def create_serial
    self.serial = serial_generator(10)
    # self.serial= (serial_generator(10)) 原形長這樣
    # self 指的是@post，在post的create action，有save這個動作
    # 在save這一連串的callback 我們要在before_create這個callback
    # 為文章加上序號。
  end

  def serial_generator(num)
    [*"a".."z",*"A".."Z",*"0".."9"].sample(num).join
  end
  
end
