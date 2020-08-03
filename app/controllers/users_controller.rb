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