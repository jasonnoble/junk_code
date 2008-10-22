#!/usr/local/bin/ruby

require 'store'
require 'cart'

store = Store.new
cart = Cart.new(store)

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
  store.add_product(name, quantity, price)
end

print store

print "Enter products to purchase, one per line, enter blank line to continue\n"
while gets
  line = $_.chomp
  break if line =~ /^$/
  next unless store.products.keys.include?(line)
  cart.add_item(line)
end

print cart
printf("TOTAL $%.2f\n", cart.total)
