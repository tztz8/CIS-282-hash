###########################################################################################
#
#  Name:        Timbre Freeman
#  Assignment:  Hash
#  Date:        10/30/2019
#  Class:       CIS 282
#  Description: This is a project so interact with Hash var type by interact with products
#
###########################################################################################

# AutoSave Flag
$auto_save = true
# products file name
product_file_name = "products.txt"
# Menu function (copy from Rock Paper Scissors project)
$debug = false
def menu(options,with_exit)
  # Ask again
  input_work = false
  while !input_work
    # to prevent a loop
    input_work = true
    # Print the menu
    for i in 1..options.length
      puts "(#{i}) #{options[i-1]}"
    end
    # check if there is a exit
    if (with_exit)
      # Print the exit
      puts "(#{options.length+1}) to exit"
    end
    # ask user for there opinion
    print "Enter a opinion: "
    input = gets.chomp.to_i
    # check if input is valid
    if (!((input <= options.length) && (input > 0)))
      if (with_exit && input <= options.length+2)
        input_work = true
      else
        puts "Your input is not a opinion available"
        input_work = false
      end
    else
      input_work = true
    end
    # check if user it trying to turn on debug
    if (with_exit && input == options.length+2)
      $debug = !$debug
      puts "Debug is On" if ($debug)
      puts "Debug is Off" if (!$debug)
      input_work = false
    elsif (input == options.length+2)
      input_work = false
      puts "Debug can not be accessed from this menu"
    end
  end
  puts ""
  return input
end

def print_hash(input_hash)
  hash_sort_by_number = input_hash.min(input_hash.length())
  puts hash_sort_by_number.inspect if $debug
  #[[123, ["shirt", 9.99]], [234, ["pants", 19.5]], [456, ["socks", 3.99]]]
  puts "Item   Description   Price"
  puts "----   -----------   -----"
  for i in 0...hash_sort_by_number.length()
    print format("%4d", hash_sort_by_number[i][0])
    print "   "
    print hash_sort_by_number[i][1][0]
    print " "*((11+3)-hash_sort_by_number[i][1][0].length)
    puts format("%0.2f",hash_sort_by_number[i][1][1])
  end
end

def load_product_file(product_file_name)
  # Load products.txt file
  puts "Loading #{product_file_name}"
  # Check if the file exists
  if (File.exists?(product_file_name))
    products_file = File.open(product_file_name, "r")
  else
    puts "#{product_file_name} dose not exists -- making file now"
    products_file = File.open(product_file_name, "w+")
  end
  # make the hash from the file
  products_hash = Hash.new
  while !products_file.eof?
    products_file_string = products_file.gets.chomp
    product_info = products_file_string.split(',')
    products_hash[product_info[0].to_i] = [product_info[1],product_info[2].to_f]
  end
  # close file (because we do not need the file open at this time we can let other look at the file)
  products_file.close
  puts "Done"
  return products_hash
end

# save the products file
def save_products_file(product_file_name,products_hash)
  if $debug
    puts "File Hash before save"
    print_hash(load_product_file(product_file_name))
    puts "New Hash"
    print_hash(products_hash)
  end
  # reopen product file
  puts "Saving File"
  # reopen as a new file
  products_file = File.open(product_file_name, "w+")
  # wright all the data from the hash
  products_hash.each do |key, value|
    products_file.print key
    products_file.print ","
    products_file.print value[0]
    products_file.print ","
    products_file.puts value[1]
  end
  # close file
  puts "Done"
  products_file.close
end

# print intro screen
puts "############################"
puts "#           Hash           #"
puts "# Products Control Program #"
puts "############################"

# load products file
products_hash = load_product_file(product_file_name)
# menu
run_program = true
while run_program == true
  puts "########"
  puts "# Menu #"
  puts "########"
  menu_items = [
      "List all products",
      "Add/Update a product",
      "Delete a product",
      "View highest priced product",
      "View lowest priced product",
      "View sum of all products price's",
      "Toggle to auto save when exit program",
      "Save #{product_file_name} now"
  ]
  user_menu_input = menu(menu_items, true)
  # Opinion 1 list all products(hash) sorted by the ID
  if user_menu_input == 1
    print_hash(products_hash)
  # Opinion 2 add or edit a product (new product get a new unique ID)
  elsif user_menu_input == 2
    # get the product id from the user
    print "Product ID: "
    product_id = gets.chomp.to_i
    puts ""
    # check if the product all ready exists
    if products_hash[product_id] == nil
      # the product does not exists
      puts "ADDING PRODUCT"
    else
      # let the user know that they are editing the product
      puts "EDITING PRODUCT"
      # print the product for the user
      puts "Original Description: #{products_hash[product_id][0]}"
      puts "Original Price: #{products_hash[product_id][1]}"
      products_hash.delete(product_id) # delete the product to let the user change the id
      puts ""
      print "New ID:"
      product_id = gets.chomp.to_i
      if products_hash[product_id] != nil
        # let the user know they are overwriting a exists product
        puts ""
        puts "You are now overwrite the product that has ID: #{product_id}"
        puts "Overwrite product Description: #{products_hash[product_id][0]}"
        puts "Overwrite product Price: #{products_hash[product_id][1]}"
      end
    end
    # get the new description
    puts ""
    print "Description: "
    product_description = gets.chomp
    # get the new price
    puts ""
    print "Price: "
    product_price = format("%0.2f", gets.chomp).to_f
    # saving the product
    products_hash[product_id] = [product_description, product_price]
  # Opinion 3 delete a product
  elsif user_menu_input == 3
    # get the product id
    print  "Product ID: "
    product_id = gets.chomp.to_i
    puts ""
    # Check if there is a product with ID given
    if products_hash[product_id] == nil
      # Let the user know that there is no product with the id given
      puts "There is no product that has ID:#{product_id}"
    else
      # Let the user know what the product was that is now delete
      puts "Product selected is: ID:#{product_id} Description:#{products_hash[product_id][0]} Price:$#{format("%0.2f",products_hash[product_id][1])}"
      products_hash.delete(product_id)
      puts "Product is now delete"
    end
  # Opinion 5 View highest priced product
  elsif user_menu_input == 4
    first_product = true
    products_hash.each do |key, value|
      # check if it is the first scan product - if it is get all the variables for all other checks
      if (first_product)
        product_id = key
        product_price = value[1]
        first_product = false
      end
      # check if the product has a grader price than lass biggest price product
      if (value[1] > product_price)
        product_id = key
        product_price = value[1]
      end
    end
    # let the user know what the product is
    puts "Product with the highest priced is:"
    puts "ID:#{product_id} Description: $#{products_hash[product_id][0]} Price:$#{format("%0.2f",products_hash[product_id][1])}"
  # Opinion 6 View lowest priced product
  elsif user_menu_input == 5
    first_product = true
    products_hash.each do |key, value|
      # check if it is the first scan product - if it is get all the variables for all other checks
      if (first_product)
        product_id = key
        product_price = value[1]
        first_product = false
      end
      # check if the product has a smaller price than lass smalles price product
      if (value[1] < product_price)
        product_id = key
        product_price = value[1]
      end
    end
    # let the user know what the product is
    puts "Product with the lowest priced is:"
    puts "ID:#{product_id} Description:#{products_hash[product_id][0]} Price:$#{format("%0.2f",products_hash[product_id][1])}"
  # Opinion 7 View sum of all product (prices)
  elsif user_menu_input == 6
    products_sum_price = 0
    # go throw each product and add up the price's
    products_hash.each {|key, value| products_sum_price = products_sum_price+value[1]}
    # let the user know the price
    puts "Sum of all products prices is: #{format("%0.2f",products_sum_price)}"
  # Opinion 8 turn off autosave
  elsif user_menu_input == 7
    # flip flop the auto save flag
    $auto_save = !$auto_save
    # let the use know what the flag is set to
    if $auto_save
      puts "Auto Save is on"
    else
      puts "Auto Save is off"
    end
  # Save the products the file now
  elsif user_menu_input == 8
    save_products_file(product_file_name,products_hash)
  # exit
  else
    # check if the user is leaving or type something else
    if user_menu_input != (menu_items.length+1)
      puts "Error: wrong input => exiting"
      puts "user input was \"#{user_menu_input}\"" if $debug
      puts "Setting autosave to false"
      # setting auto save off so the file is not filled with potential garbage
      $auto_save = false
    end
    run_program = false
  end
  puts ""
end
# save product file
if $auto_save
  save_products_file(product_file_name,products_hash)
else
  puts "Auto save is off => printing all products"
  print_hash(products_hash)
  puts "****************************************"
  puts "* PRODUCTS ARE NOT SAVE TO #{product_file_name}*"
  puts "****************************************"
end