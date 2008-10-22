#!/usr/local/bin/ruby

require 'test/unit'
require 'store'
require 'cart'

class CheckoutTest < Test::Unit::TestCase
  def test_store_create
    store = Store.new
    assert store
    assert_equal 0, store.products.length
    
    store.add_product("a", "1", "0.50")
    assert_equal 1, store.products.length
    assert_equal 1, store.products["a"].length
    
    store.add_product("a", "3", "1.20")
    assert_equal 1, store.products.length
    assert_equal 2, store.products["a"].length
  end
  
  def test_cart_create
    store = setup_store1
    cart = Cart.new(store)
    assert cart
    assert_equal 0, cart.items.length
    cart.add_item("a")
    assert_equal 1, cart.items.length
    assert_equal 1, cart.items['a']
    
    cart.add_item("a")
    assert_equal 1, cart.items.length
    assert_equal 2, cart.items['a']
  end
  
  def test_total_1
    store = setup_store1
    cart = Cart.new(store)
    assert cart
    cart.add_item("a")
    cart.add_item("a")
    cart.add_item("b")
    cart.add_item("a")
    assert_equal 3, cart.items['a']
    assert_equal 1, cart.items['b']
    assert_equal 1.50, cart.total
  end
  
  def test_total_2
    store = setup_store1
    cart = Cart.new(store)
    assert cart
    cart.add_item("c")
    cart.add_item("c")
    cart.add_item("a")
    cart.add_item("c")
    cart.add_item("a")
    cart.add_item("c")
    cart.add_item("b")
    cart.add_item("c")
    cart.add_item("c")
    cart.add_item("a")
    cart.add_item("b")
    cart.add_item("a")
    cart.add_item("b")
    assert_equal 4, cart.items['a']
    assert_equal 3, cart.items['b']
    assert_equal 6, cart.items['c']

    assert_equal 27.60, cart.total
  end
  
  def test_total_3
    store = setup_store1
    cart = Cart.new(store)
    assert cart
    cart.add_item("b")
    cart.add_item("c")
    cart.add_item("c")
    assert_nil cart.items['a']
    assert_equal 1, cart.items['b']
    assert_equal 2, cart.items['c']
    
    assert_equal 10.30, cart.total
  end
  
  def test_total_4
    # Five Finger Discount
    store = setup_store2
    cart = Cart.new(store)
    cart.add_item('a')
    assert_equal 0, cart.total
    25.times do
      cart.add_item('a')
    end
    assert_equal 26, cart.items['a']
    assert_equal 0, cart.total
  end
  
  def broken_total_5
    store = setup_store3
    cart = Cart.new(store)
    cart.add_item('b')
    assert_equal 1, cart.items['b']
    assert_equal 0.15, cart.total
    
    cart.add_item('a')
    # Broken
    assert_equal 0.45, cart.total
    
    10.times do
      cart.add_item('a')
    end
    print cart
    print store
    assert_equal 10.45, cart.total
  end
  
  # Helper Methods
  def setup_store1
    # Provided example
    store = Store.new
    store.add_product("a", "1", "0.50")
    store.add_product("a", "3", "1.20")
    store.add_product("b", "1", "0.30")
    store.add_product("c", "1", "5.00")
    store.add_product("c", "6", "25.0")
    return store
  end
  
  def setup_store2
    # Everything is free
    store = Store.new
    store.add_product("a", "1", "0.00")
    return store
  end
  
  def setup_store3
    # Multiple discount levels
    store = Store.new
    store.add_product("a", "1", "0.30")
    store.add_product("c", "10", "2.50")
    store.add_product("d", "100", "10.00")
    store.add_product("b", "1", "0.15")
    return store
  end
end