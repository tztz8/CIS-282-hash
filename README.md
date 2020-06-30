# CIS-282-hash
For SCC CIS 282 class

DOC -> MD

**CIS 282**

**Hash Assignment**

**To turn in:**

- Attach a file hash\_lastname.rb as an attachment to the assignment in Canvas

**To do:**

Create a menu driven program to interact with a set of products. You&#39;ll use a hash where a random 3 digit number is the key and the value is a two element array containing the name of the product and the price. Initialize the hash with at least 3 products (from the file &quot;products.txt&quot; as described below).

The format of the hash would look like this:

products = {124=\&gt;[&quot;shoes&quot;,59.99], 352=\&gt;[&quot;shirt&quot;,19.99], 456=\&gt;[&quot;socks&quot;, 3.99]}

  - Your program will let the user:
    1. view all products – sorted by the ID of the product in ascending order
    2. add a new product
      - make sure key is unique, in other words don&#39;t overwrite existing pair
    3. delete a product (give error message if product does not exist)
    4. update a product (give error message if product does not exist)
      - separate prompts for both description and price
    5. view highest priced product (print out full info of item)
    6. view lowest priced product (print out full info of item)
    7. view sum of all product prices (provide description of output user sees)
    8. exit

- Initialize your program by reading the products from a text file called &quot;products.txt&quot; for your products so that you have some starting data. Fill the file with lines of data that look like the following. You must have at least 3 products.


123,shirt,9.99
 234,pants,19.50
 456,socks,3.99

- When you list products, make the reports list the ID of the product, name, and price like below. Description can take up more room and price could be up to 5 significant digits (125.55)

Item Description Price

----- -------------- ------

124 shoes 59.99

352 shirt 19.99

- Make your menu how you wish as long as there are options for all of the functions listed above.
- When your program exits, Save all products to a file called &quot;products.txt&quot; – the same file that you opened and read to initialize your program with. This should not have to be a separate menu item but it should save automatically on quit.
