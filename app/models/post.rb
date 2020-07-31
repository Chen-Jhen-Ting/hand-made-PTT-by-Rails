class Post < ApplicationRecord

  validates :title, presence: true, length: {minimum: 2}
  validates :serial, uniqueness: true


  belongs_to :board
  # 這一段產生了 board  board= 方法給 Post 用

  before_create :create_serial

  private

  def create_serial
    self.serial = serial_generator(10)
    # self.serial= (serial_generator(10)) 原形長這樣
  end

  def serial_generator(num)
    [*"a".."z",*"A".."Z",*"0".."9"].sample(num).join
  end
  
end
