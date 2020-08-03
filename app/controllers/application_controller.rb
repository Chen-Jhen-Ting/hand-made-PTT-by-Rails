class ApplicationController < ActionController::Base
    include UsersHelper
    # 這邊是把 view  helper module 的方法拉過來

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    # before_action :find_user
    # 這個工作交給view helper去做

    helper_method :user_signed_in?, :current_user
    # 這樣的寫法是把方法設定在controller 然後用helper_method 讓view可以用
    
    private
    def not_found
        render file: '/public/404.html', state: 404
    end

    # def find_user
    #     if session[:user_token]
    #         @current_user = User.find(session[:user_token])
    #     end
    # end
    # 丟給view helper去做

    # def user_signed_in?
    #     session[:user_token]
    # end
    # 我們自製的方法

    def user_signed_in?
        current_user != nil
    end
    # 官方給的方法


    # def current_user
    #     User.find(session[:user_token]) if user_signed_in?
    # end 
    # 我們自製的方法
    # 這樣的寫法是把方法設定在controller 然後用helper_method 讓view可以用

    def current_user
        @current_user ||= User.find_by(id: session[:user_token])
    end
    # 官方給的方法


    def authenticate_user!
        redirect_to root_path, notice: '請登入' if not user_signed_in?
    end
    # 本來掛在board controller 有很多地方要用這個，所以把它掛在這裡
    # require_user_sign_in 這邊我們改成 authenticate_user! 模仿 device套件
end
