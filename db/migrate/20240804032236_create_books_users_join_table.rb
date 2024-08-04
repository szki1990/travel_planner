class CreateBooksUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :books_users, id: false do |t|
      t.belongs_to :book
      t.belongs_to :user
    end 
  end
end
