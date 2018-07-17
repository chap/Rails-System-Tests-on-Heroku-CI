class AddTest1ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :test_1, :string
  end
end
