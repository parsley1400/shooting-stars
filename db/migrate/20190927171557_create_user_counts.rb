class CreateUserCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_counts do |t|
      t.references :user_id
      t.references :count_id
    end
  end
end
