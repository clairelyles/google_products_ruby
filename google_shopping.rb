#RUBY!! no more semi-colons... ever.

require 'json'
file = File.read("./products.json")

#Welcome to RUBY we use snake case now
#snake case word_word not camel case wordWord
google_data = JSON.parse(file)
items = google_data["items"]

# formatting --------------------------------------------------
def output_items items
    items.each do |item|
        puts "brand:  #{item['product']['brand']}"
        puts "price:  $#{item['product']['inventories'].first['price']}"
        puts "image count: #{item['product']['images'].length}"
        # print first image only
        puts "image:  #{item['product']['images'].first['link']}"
        # prints multiple images, if they are > 1
        # item['product']['images'].each_with_index do |image,index|
        #     puts "image #{index}: #{image['link']}"
        # end
        puts " "
    end
end

# question 1 --------------------------------------------------
# the `kind` of results you're are dealing  are `shopping#products`. 
def shopping_products items
	items.select do |item|
		item['kind']=='shopping#product'
	end
end

puts 'Question #1:'
puts shopping_products(items).length
puts '=' * 55

# question 2 --------------------------------------------------
# find all items with a `backorder` availability in `inventories`.
def backorder_availability items
	items.select do |item|
		backorders = item['product']['inventories'].select do |inv_avail|
			inv_avail['availability'] == 'backorder'
		end
		backorders.length > 0
	end
end

puts 'Question #2:'
puts backorder_availability(items).length
puts output_items backorder_availability(items)
puts '=' * 55

# question 3 --------------------------------------------------
# find all items with more than one image link.
def images_links items
	items.select do |item|
		item['product']['images'].length > 1
	end
end

puts 'Question #3:'
puts images_links(items).length
puts output_items images_links(items)
puts '=' * 55

# question 4 --------------------------------------------------
# find all `canon` products in the items (careful with case sensitivity).
def canon_products items
	items.select do |item|
		item['product']['brand'].downcase == 'canon'
	end
end

puts 'Question #4:'
puts canon_products(items).length
puts output_items canon_products(items)
puts '=' * 55

# question 5 --------------------------------------------------
# find all `items` that have **product** **author** **name** of "eBay" and are brand "Canon".
def ebay_products items
	items.select do |item|
		item['product']['author']['name'].downcase == 'ebay'
	end
end

canon = canon_products(items)
puts 'Question #5:'
puts "All eBay products: #{ebay_products(items).length}"
puts "All canon and eBay products: #{ebay_products(canon).length}"
puts output_items ebay_products(canon)
puts '=' * 55

# question 6 --------------------------------------------------
# print all the products with their **brand**, **price**, and a **image link**
puts 'Question #6:'
puts output_items items
puts '=' * 55


