class User < ApplicationRecord
    validates :account, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    acts_as_paranoid
    before_create :encrypt_password


    has_many :board_masters
    has_many :boards, through: :board_masters


    
    def self.login(options)
        if options[:account] && options[:password]
            find_by( account: options[:account], password: Digest::SHA1.hexdigest("x"+options[:password]+"y") )
                    # password: bigbang(options[:password]) 
        # else
        #     false  
        # 沒有填入帳號密碼，就給他false
        # 填入帳號密碼卻找不到，find_by會給他nil
        end
    end
    # 這邊定義的是類別方法


    private
    def encrypt_password
        self.password = bigbang(self.password)
    end

    def bigbang(string)
        string = "x" + string + "y"
        Digest::SHA1.hexdigest(string)
    end

end
