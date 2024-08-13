import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favourites_controller.dart';
import '../models/cart_model.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String imagePath;
  final String title;
  final String weight;
  final double price;
  final String buttonText;
  final VoidCallback onPressed;

  const ProductCard({
    super.key,
    required this.id,
    required this.imagePath,
    required this.title,
    required this.weight,
    required this.price,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController = Get.put(CartController());
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  bool isFavorite = false;

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
    final CartItem item = CartItem(
      id: widget.id,
      imagePath: widget.imagePath,
      title: widget.title,
      weight: widget.weight,
      price: widget.price,
    );
    int quantity = getQuantity();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.grey),
      ),
      elevation: 0,
      color: Colors.white,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    widget.imagePath,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 6,
                    right: 0,
                    child: IconButton(
                      iconSize: 25,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        if (isFavorite) {
                          favoritesController.addItem(item);
                        } else {
                          favoritesController.removeItem(item.id);
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 0,
                    child: IconButton(
                      icon: Image.asset('assets/icons/list-btn.png',
                          width: 25, height: 25),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              widget.weight,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              '${widget.price} tk',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     cartController.addItem(item);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.green,
            //     backgroundColor: Colors.white,
            //     elevation: 0.0,
            //     side: const BorderSide(color: Color(0xFFB3B300)),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //   ),
            //   child: Center(
            //     child: Text(
            //       widget.buttonText,
            //       style: const TextStyle(color: Color(0xFFB3B300)),
            //     ),
            //   ),
            // ),

            if (quantity == 0) ...[
              ElevatedButton(
                onPressed: addToCart,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                  elevation: 0.0,
                  side: const BorderSide(color: Color(0xFFB3B300)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.buttonText,
                    style: const TextStyle(color: Color(0xFFB3B300)),
                  ),
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF999900),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: const Color(0xFFB3B300)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: const Icon(Icons.remove, color: Colors.white),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
