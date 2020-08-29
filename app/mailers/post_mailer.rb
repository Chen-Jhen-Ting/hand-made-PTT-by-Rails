class PostMailer < ApplicationMailer
    # 在這裡定義的方法都會被 action mailer 變成類別方法
    def poster
        @post = params[:post]
        mail(to: @post.user.email, subject: "新增文章： #{@post.title}")
                # 發送給文章的作者
    end
end
