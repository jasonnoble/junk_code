class Cart
  def initialize(store=nil)
    return false if store.nil?
    @items = Hash.new
    @store = store
  end
  
  def add_item(name)
    unless @items.keys.include?(name)
      @items[name] = 0
    end
    @items[name] += 1
  end
  
  def items
    @items
  end
  
  def total
    total = 0
    @items.keys.each {|item|
      quantity = @items[item]
      total += @store.subtotal(item,quantity)
    }
    return total
  end
  
  def to_s
    puts "Items in your cart"
    print "="*25, "\n"
    @items.keys.each {|item|
      quantity = @items[item]
      printf("%s %d $%.2f\n", item, quantity, @store.subtotal(item, quantity))
    }
    print "="*25, "\n"
    return ""
  end
end