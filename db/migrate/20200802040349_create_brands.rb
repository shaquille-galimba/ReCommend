class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
