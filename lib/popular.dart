import 'package:ecom/product_description.dart';
import 'package:ecom/widgets/sort-btn.dart';
import 'package:flutter/material.dart';
import 'package:ecom/widgets/productcard.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'product_list_data/popular_products.dart';
import 'shopping_cart.dart';

class PopularPage extends StatelessWidget {
  PopularPage({super.key});

  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: const Text('Popular'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
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
                      // child: Icon(Icons.shopping_cart)
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
          toolbarHeight: 70.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.grey, // Change this to your desired border color
                width: 1.0,
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const SortFilterBottomSheet(),
                    );
                  },
                  child: const Text(
                    'Sort & Filter',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${popularProducts.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text: ' items',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: GridView.builder(
            itemCount: popularProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemBuilder: (context, index) {
              final product = popularProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDescription(
                        id: product['id'],
                        imagePath: product['imagePath'],
                        title: product['title'],
                        weight: product['weight'],
                        price: product['price'],
                        description: product['description'],
                      ),
                    ),
                  );
                },
                child: ProductCard(
                  id: product['id'],
                  imagePath: product['imagePath'],
                  title: product['title'],
                  weight: product['weight'],
                  price: product['price'],
                  buttonText: product['buttonText'],
                  onPressed: () {},
                  // onFavoritePressed: () {
                  //   // Handle favorite action
                  // },
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
