class ApplicationController < ActionController::Base
    
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    before_action :find_user
    
    
    private
    def not_found
        render file: '/public/404.html', state: 404
    end

    def find_user
        if session[:user_token]
            @current_user = User.find_by( session[:user_find] )
        end
    end
end
