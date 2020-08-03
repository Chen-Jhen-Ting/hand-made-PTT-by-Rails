class UsersController < ApplicationController
    def sign_up
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # 登入
            session['user_token']= @user.id
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

    def sing_in
        
    end
    private
    def user_params
        params.require(:user).permit(:account, :password, :email)
    end
end