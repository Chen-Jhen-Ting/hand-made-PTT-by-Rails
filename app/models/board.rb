class Board < ApplicationRecord

    acts_as_oaranoid


    has_many :posts
    # has_many :posts 這便是增加方法，不是建立關聯，這些關聯都是虛假的，只有方法才是真的
    # 會長出  posts  posts 這些方法
    # has_many :posts, foreign_key 'board_id'  FK 預設是這樣，可以自己更改


    validates :title, presence: true, length: {minimum: 2}
    # 驗證寫在model 相對安全



    # scope :available, -> { where(deleted_at: nil) }


    # default_scope :available, -> { where(deleted_at: nil) }
    # default_scope 是讓每次查詢加上這個條件，確定每次都要加這個條件再使用

    def destroy
        update(deleted_at: Time.now)
    end
    # 這邊是利用後代會覆寫前代的寫法。我們自己定義了這個 destory，這要確定所有的model都要這種
    # 刪除才可以這樣做
   
end
