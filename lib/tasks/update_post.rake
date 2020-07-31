namespace :db do
    desc " 更新文章序號 "
    task :update_post_serial => :environment do
        puts "Updating serial"
        Post.where(serial: nil).each do |post|
            post.update(serial: serial_generator(10))
            print "."
        end
        puts "done!"
    end

    private
    def serial_generator(num)
        [*"a".."z",*"A".."Z",*"0".."9"].sample(num).join
    end
end

