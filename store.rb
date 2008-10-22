class Store
  def initialize()
    @products = Hash.new
  end
  
  def add_product(name, quantity, price)
    quantity = quantity.to_i
    price = price.to_f
    unless @products.keys.include?(name)
      @products[name] = Hash.new
    end
    @products[name][quantity] = price
  end
  
  def subtotal(product, quantity)
    price = 0
    while quantity > 0
      self.products[product].keys.sort.reverse.each {|limit|
        modulo = quantity % limit
        div = quantity / limit
        if modulo >= 0
          price += div * self.products[product][limit]
          quantity -= div * limit
        end
      }
    end
    return price
  end
  
  def products
    @products
  end
  
  def to_s
    puts "Items in your store"
    print "="*25, "\n"
    @products.keys.sort.each {|product|
      print "#{product}\n"
      @products[product].keys.sort.each {|quantity|
        printf("\t%d for $%.2f\n", quantity, @products[product][quantity])
      }
    }
    print "="*25, "\n\n\n"
    return ""
  end
end