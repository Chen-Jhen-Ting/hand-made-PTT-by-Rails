class SendmailJob < ApplicationJob
  queue_as :default

  # SendmailJob.perform_later(@post)
  def perform(post)
    puts "-------------------------------"
    PostMailer.with(post: post).poster.deliver_later
    puts "-------------------------------"
    # Do something later
  end
end
