class AddRecommendsCountToBrands < ActiveRecord::Migration[6.0]
  def change
    add_column :brands, :recommends_count, :integer
  end
end
