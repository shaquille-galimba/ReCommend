class ResetAllBrandCacheCounters < ActiveRecord::Migration[6.0]
  def change
		Brand.all.each do |brand|
			Brand.reset_counters(brand.id, :recommends)
		end
  end
end
