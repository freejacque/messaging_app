class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :registerable
      t.string :confirmable
      t.timestamps
    end
  end
end
