class CreateRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :recommends do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :brand, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
