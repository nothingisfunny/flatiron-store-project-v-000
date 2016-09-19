class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    prices_array = self.line_items.map(&:item_id).map{|id|Item.find(id).price}
    quantities_array = self.line_items.map(&:quantity)
    total = prices_array.zip(quantities_array).map{|i,j| i*j }.inject(:+)
    total
  end

  def add_item(item_id)
    line_item = LineItem.find_by(item_id: item_id, cart_id: self.id)
    if line_item 
      line_item.quantity += 1
      line_item
    else
     LineItem.new(item_id: item_id, cart_id: self.id)
    end
  end
end
