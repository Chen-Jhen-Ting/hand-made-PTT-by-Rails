class UsersController < ApplicationController
    def sign_up
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # 登入

            # session[:user_token]= @user.id   
            # 上面這一行變成下面這一行更有意義
            sign_in_user(@user)
            
            # session 就像是五十嵐店員手上的號碼單
            # cookie 就像是你手上的號碼單
            # 兩個都要對應才有效
            # 讓session 接收 @user.id 後來查詢的時候要用 find(id) 
            # 如果存@user.account 就find_by(account: :account)

            # 去首頁
            redirect_to root_path, notice: '會員註冊成功'
        else
            render :sign_up
        end
    end

    def sign_in
        @user = User.new()
    end

    def login
        # if user_params[:account] && user_params[:password]
        #     # 認證
        #     user = User.login(user_params)
        #     # 這邊User.login 是user model那邊定義好的。
        #     if user
        #         sign_in_user(user)
        #         redirect_to root_path, notice: '成功登入'
        #     else
        #         redirect_to sign_in_users_path, notice:'請輸入正確帳號'
        #     end
        # else
        #     redirect_to sign_in_users_path, notice:'請輸入正確帳號'
        # end

        user = User.login(user_params)
        if user
            sign_in_user(user)
            redirect_to root_path, notice: '成功登入'
        else
            redirect_to sign_in_users_path, notice:'請輸入正確帳號'
        end
        # 簡化成這樣是因為 User.login  if options[:account] && options[:password]的這行就有檢查是否輸入帳號密碼
        # 不需要向上方寫法檢查兩次
    end

    def sign_out
        # session[:user_token] = nil
        # 上面這一行改成下面這一行，更有意義
        sign_out_user()
        redirect_to root_path,notice: '登出成功'
    end
    # 把session 刪掉，就可以登出了

    private
    def user_params
        params.require(:user).permit(:account, :password, :email)
    end

    def sign_in_user(user)
        session[:user_token]= user.id
        # 把user.id 夾入session讓後續查詢可以抓到user.id
    end

    def sign_out_user
        session[:user_token] = nil
        # 這邊是撕掉session
    end

end