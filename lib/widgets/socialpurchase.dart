import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/cart_model.dart';

class SocialDiscountCard extends StatefulWidget {
  final String id;
  final String imagePath;
  final String title;
  final String weight;
  final String originalPrice;
  final String discountedPrice;
  final int progressPercentage;
  final int endTime;
  final VoidCallback onAddToCart;

  const SocialDiscountCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.weight,
    required this.originalPrice,
    required this.discountedPrice,
    required this.progressPercentage,
    required this.endTime,
    required this.onAddToCart,
    required this.id,
  });

  @override
  State<SocialDiscountCard> createState() => _SocialDiscountCardState();
}

class _SocialDiscountCardState extends State<SocialDiscountCard> {
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
      price: double.tryParse(widget.discountedPrice.trim()) ?? 0.0,
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
      price: double.tryParse(widget.discountedPrice.trim()) ?? 0.0,
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2, // Adjust the flex value to allocate space as needed
            child:
                Image.asset(widget.imagePath, height: 120, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3, // Adjust the flex value to allocate space as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(widget.weight),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.originalPrice,
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(widget.discountedPrice),
                  ],
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: widget.progressPercentage / 100.0,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                ),
                const SizedBox(height: 5),
                Text(
                  '${widget.progressPercentage}% Completed (Left ${100 - widget.progressPercentage} out of 100)',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 5),
                CountdownTimer(
                  endTime: widget.endTime,
                  widgetBuilder: (_, time) {
                    if (time == null) {
                      return const Text('Deal ended');
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTimeCard(time.days ?? 0, 'Day'),
                        _buildTimeCard(time.hours ?? 0, 'Hrs'),
                        _buildTimeCard(time.min ?? 0, 'Min'),
                        _buildTimeCard(time.sec ?? 0, 'Sec'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                // SizedBox(
                //   width: double.infinity,
                //   height: 40,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       side: const BorderSide(color: Color(0xFFB3B300)),
                //       backgroundColor: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20.0),
                //       ),
                //     ),
                //     onPressed: widget.onAddToCart,
                //     child: const Text(
                //       'Add to cart',
                //       style: TextStyle(color: Color(0xFFB3B300)),
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
                    child: const Center(
                      child: Text(
                        'Add to cart',
                        style: TextStyle(color: Color(0xFFB3B300)),
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
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
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
        ],
      ),
    );
  }

  Widget _buildTimeCard(int time, String label) {
    return Column(
      children: [
        Container(
          color: const Color(0xFFF2F3F5),
          padding: const EdgeInsets.all(5.0),
          child: Text(time.toString().padLeft(2, '0'),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
