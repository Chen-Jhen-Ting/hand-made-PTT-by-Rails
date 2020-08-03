class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # acts_as_paranoid
  # 不可以掛在這裡，因為borad_master不需要這個
end
