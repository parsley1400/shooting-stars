class CreateCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :counts do |t|
      t.string :name
      t.integer :number, default: 0
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
