#!/usr/local/bin/ruby

=begin
  a 3 1.20
  a 1 0.50
  b 1 0.30
  c 1 5.00
  c 6 25.00
=end

@products = Hash.new
@cart = Hash.new(0)

print "Enter skus (name quantity price), one per line, enter blank line to continue\n"

while gets
  line = $_.chomp
  break if line =~ /^$/
  if line =~ /^(\w+)\s+(\d+)\s+(\d*\.?\d{0,2})$/
    name      = $1
    quantity  = $2.to_i
    price     = $3.to_f
  else
    next
  end
  puts "Adding #{name} #{quantity} #{price}"
  @products[name] ||= Hash.new
  @products[name][quantity] = price
end

print "Available products\n"
@products.keys.each { |product|
  print "\t#{product}\n"
  @products[product].keys.sort.each {|quantity|
    printf("\t\t%5d for $%.2f\n", quantity, @products[product][quantity])
  }
}

print "Enter products to purchase, one per line, enter blank line to continue\n"
while gets
  line = $_.chomp
  break if line =~ /^$/
  next unless @products.keys.include?(line)
  @cart[line] += 1
end

total = 0
if @cart.empty?
  puts "You didn't purchase anything"
else
  @cart.keys.each {|product|
    quantity = @cart[product]
    price = 0
    while quantity > 0
      @products[product].keys.sort.reverse.each {|limit|
        modulo = quantity % limit
        div = quantity / limit
        if modulo >= 0
          price += div * @products[product][limit]
          quantity -= div * limit
        else
          price += @products[product][limit]
          quantity -= limit
        end
      }
    end
    printf("%s %2d $%.2f\n", product, @cart[product], price)
    total += price
  }
  printf("TOTAL $%.2f\n", total)
end