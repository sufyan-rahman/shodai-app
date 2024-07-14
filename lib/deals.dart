import 'package:ecom/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'models/cart_model.dart';
import 'widgets/socialpurchase.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOffersSection(cartController),
            const SizedBox(height: 5.0),
            _buildSocialDiscountSection(),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}

Widget _buildOffersSection(CartController cartController) {
  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'imagePath': 'assets/images/card1.png',
      'title': 'Orange (South Africa)',
      'weight': '1kg',
      'price': 245.0,
      'buttonText': 'Add to cart',
    },
    {
      'id': '2',
      'imagePath': 'assets/images/card2.png',
      'title': 'Gulsha Tengra (Medium)',
      'weight': '1kg',
      'price': 450.0,
      'buttonText': 'Add to cart',
    },
    {
      'id': '3',
      'imagePath': 'assets/images/card3.png',
      'title': 'Product 2',
      'weight': '100kg',
      'price': 200.0,
      'buttonText': 'Add to cart',
    },
    {
      'id': '4',
      'imagePath': 'assets/images/card4.png',
      'title': 'Product 2',
      'weight': '100kg',
      'price': 200.0,
      'buttonText': 'Add to cart',
    },
  ];

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    color: Colors.white,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today\'s Offers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator to see all offers
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
        _buildOffersList(products, cartController),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFB3B300)),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 40.0),
              ),
              onPressed: () {},
              child: const Text(
                'SEE ALL OFFERS',
                style: TextStyle(color: Color(0xFFB3B300)),
              )),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    ),
  );
}

Widget _buildOffersList(
    List<Map<String, dynamic>> products, CartController cartController) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
    ),
    itemBuilder: (context, index) {
      final product = products[index];
      return ProductCard(
        id: product['id'],
        imagePath: product['imagePath'],
        title: product['title'],
        weight: product['weight'],
        price: product['price'],
        buttonText: product['buttonText'],
        onPressed: () {
          // cartController.addItem(CartItem(
          //   id: product['id'],
          //   imagePath: product['imagePath'],
          //   title: product['title'],
          //   weight: product['weight'],
          //   price: product['price'],
          // ));
        },
        onFavoritePressed: () {
          // Handle favorite action
        },
      );
    },
  );
}

Widget _buildSocialDiscountSection() {
  final int endTime = DateTime.now().millisecondsSinceEpoch +
      1000 * 60 * 60 * 24 * 1; // 1 day from now

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    color: Colors.white,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Social Purchase',
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
        SocialDiscountCard(
          imagePath: 'assets/images/card11.png',
          title: 'Padmar Elish - Hilsha Fish (900gm - 1KG)',
          weight: '1 Kg',
          originalPrice: '৳260',
          discountedPrice: '৳245',
          progressPercentage: 30,
          endTime: endTime,
          onAddToCart: () {
            // Add to cart action
          },
        ),
        const Divider(height: 5.0),
        SocialDiscountCard(
          imagePath: 'assets/images/card12.png',
          title: 'Orange - কমলা',
          weight: '2 Kg',
          originalPrice: '৳520',
          discountedPrice: '৳400',
          progressPercentage: 40,
          endTime: endTime,
          onAddToCart: () {
            // Add to cart action
          },
        ),
      ],
    ),
  );
}
