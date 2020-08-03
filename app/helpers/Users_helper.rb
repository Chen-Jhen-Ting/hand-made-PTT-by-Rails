module UsersHelper
    
    # def find_user
    #     if session[:user_token]
    #         @current_user = User.find(session[:user_token])
    #     end
    # end
    # 從controller 拉到這裡來做得功能
    # 我們把登入功能與查詢使用者功能分開 往下看
    
    
    
    
    # def user_signed_in?
    #     session[:user_token]
    # end

    # def current_user
    #     User.find(session[:user_token]) if user_signed_in?
    # end
    # 這樣是把code 寫在module 然後include到 controller
end
