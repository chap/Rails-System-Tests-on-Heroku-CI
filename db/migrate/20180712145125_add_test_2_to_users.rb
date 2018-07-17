class AddTest2ToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :test_2, :string
  end
end
