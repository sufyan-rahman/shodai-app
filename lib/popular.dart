import 'package:ecom/widgets/sort-btn.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecom/widgets/productcard.dart';

class PopularPage extends StatelessWidget {
  const PopularPage({super.key});

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
            IconButton(
              icon: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset('assets/icons/cart2.png'),
              ),
              onPressed: () {
                // Define what happens when the button is pressed
                if (kDebugMode) {
                  // print('Button with image pressed');
                }
              },
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
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.vertical(
                      //     top: Radius.circular(20),
                      //   ),
                      // ),
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
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '12,001',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
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
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.6,
              children: [
                ProductCard(
                  imagePath: 'assets/images/card1.png',
                  title: 'Danish Full Cream Milk Powder',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card2.png',
                  title: 'Nestle asd asdkjsd sdasdksd sdasd',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card3.png',
                  title: 'Danish Full Cream Milk Powder',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card4.png',
                  title: 'Nestle asd asdkjsd sdasdksd sdasd',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card5.png',
                  title: 'Danish Full Cream Milk Powder',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card6.png',
                  title: 'Nestle asd asdkjsd sdasdksd sdasd',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card7.png',
                  title: 'Danish Full Cream Milk Powder',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card8.png',
                  title: 'Nestle asd asdkjsd sdasdksd sdasd',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card9.png',
                  title: 'Danish Full Cream Milk Powder',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card10.png',
                  title: 'Nestle asd asdkjsd sdasdksd sdasd',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
                ProductCard(
                  imagePath: 'assets/images/card11.png',
                  title: 'Danish Full Cream Milk Powder',
                  weight: '1 Kg',
                  price: '৳609',
                  buttonText: 'Add to cart',
                  onPressed: () {
                    // Add to cart action
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
