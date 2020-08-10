class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :content
      t.string :ip_address
      t.string :comment_type

      t.timestamps
    end
  end
end
