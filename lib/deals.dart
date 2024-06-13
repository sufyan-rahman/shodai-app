import 'package:ecom/widgets/productcard.dart';
import 'package:flutter/material.dart';

class DealsPage extends StatelessWidget {
  DealsPage({super.key});

  final List<Map<String, dynamic>> products = [
    {
      'imagePath': 'assets/images/card1.png',
      'title': 'Orange (South Africa)',
      'weight': '1kg',
      'price': '245tk',
      'buttonText': 'Add to cart',
      'onPressed': () {},
    },
    {
      'imagePath': 'assets/images/card2.png',
      'title': 'Gulsha Tengra (Medium)',
      'weight': '1kg',
      'price': '450tk',
      'buttonText': 'Add to cart',
      'onPressed': () {},
    },
    {
      'imagePath': 'assets/images/card3.png',
      'title': 'Product 2',
      'weight': '100kg',
      'price': '200tk',
      'buttonText': 'Add to cart',
      'onPressed': () {},
    },
    {
      'imagePath': 'assets/images/card4.png',
      'title': 'Product 2',
      'weight': '100kg',
      'price': '200tk',
      'buttonText': 'Add to cart',
      'onPressed': () {},
    },
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today' 's Offers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the ProductsPage when the button is pressed
                  },
                  child: const Text(
                    'SEE ALL >',
                    style: TextStyle(
                        color: Color(0xFFB3B300),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: 0.55, // Adjust the ratio as needed
                  // crossAxisSpacing: 8.0,
                  // mainAxisSpacing: 8.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: products[index]['title'],
                    imagePath: products[index]['imagePath'],
                    price: products[index]['price'],
                    weight: products[index]['weight'],
                    buttonText: products[index]['buttonText'],
                    onPressed: () {},
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'SEE ALL OFFERS',
                ))
          ],
        ),
      ),
    );
  }
}
