import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String weight;
  final String price;
  final String buttonText;
  final VoidCallback onPressed;
  final VoidCallback onFavoritePressed;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.weight,
    required this.price,
    required this.buttonText,
    required this.onPressed,
    required this.onFavoritePressed,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
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
                      icon: const Icon(
                        Icons.favorite_border,
                      ),
                      onPressed: widget.onFavoritePressed,
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
              widget.price,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green,
                backgroundColor: Colors.white,
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
          ],
        ),
      ),
    );
  }
}