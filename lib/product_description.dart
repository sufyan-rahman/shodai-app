import 'package:ecom/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'models/cart_model.dart';

class ProductDescription extends StatefulWidget {
  final String id;
  final String imagePath;
  final String title;
  final String weight;
  final double price;
  final String description;

  ProductDescription({
    Key? key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.weight,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  final CartController cartController = Get.put(CartController());

  int getQuantity() {
    int index =
        cartController.cartItems.indexWhere((item) => item.id == widget.id);
    if (index != -1) {
      return cartController.cartItems[index].quantity;
    }
    return 0;
  }

  void addToCart() {
    cartController.addItem(CartItem(
      id: widget.id,
      imagePath: widget.imagePath,
      title: widget.title,
      weight: widget.weight,
      price: widget.price,
      quantity: 1, // Initial quantity when adding to cart
    ));
    setState(() {});
  }

  void incrementQuantity() {
    cartController.addItem(CartItem(
      id: widget.id,
      imagePath: widget.imagePath,
      title: widget.title,
      weight: widget.weight,
      price: widget.price,
      quantity: 1,
    ));
    setState(() {});
  }

  void decrementQuantity() {
    int index =
        cartController.cartItems.indexWhere((item) => item.id == widget.id);
    if (index != -1) {
      cartController.removeItem(cartController.cartItems[index]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int quantity = getQuantity();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.reply),
          ),
          Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset('assets/icons/cart2.png'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShoppingCartPage(),
                      ),
                    );
                  },
                ),
                if (cartController.totalItems > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7D7D00),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cartController.totalItems}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Center(
                    child: Image.asset(widget.imagePath,
                        height: MediaQuery.of(context).size.height * 0.35,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 10.0),

                  // Product Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  // Product Price
                  Text(
                    widget.weight,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  // Product Weight

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.price} tk",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border))
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.format_list_bulleted_add),
                      const SizedBox(
                        width: 5.0,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Add to List'),
                      )
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(),

                  // Product Description
                  ExpansionTile(
                    title: const Text('Product Description'),
                    children: [
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (quantity == 0) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF999900),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                ),
                child: const Text('Add to cart',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF999900),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: decrementQuantity,
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: incrementQuantity,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
