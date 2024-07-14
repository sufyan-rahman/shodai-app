import 'package:ecom/eidspecial.dart';
import 'package:ecom/inspiredby.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'popular.dart';
import 'package:ecom/widgets/productcard.dart';
import 'package:ecom/provider/items_provider.dart';
import 'package:provider/provider.dart';

import 'product_list_data/popular_products.dart';

class Home extends StatelessWidget {
  final VoidCallback navigateToCategories;

  Home({super.key, required this.navigateToCategories});

  // final List<Map<String, dynamic>> popularproducts = [
  //   {
  //     'id': '10',
  //     'imagePath': 'assets/images/card1.png',
  //     'title': 'Orange (South Africa)',
  //     'weight': '1kg',
  //     'price': '245tk',
  //     'buttonText': 'Add to cart',
  //     'onPressed': () {},
  //     'onFavoritePressed': () {}
  //   },
  //   {
  //     'id': '11',
  //     'imagePath': 'assets/images/card2.png',
  //     'title': 'Gulsha Tengra (Medium)',
  //     'weight': '1kg',
  //     'price': '450tk',
  //     'buttonText': 'Add to cart',
  //     'onPressed': () {},
  //     'onFavoritePressed': () {}
  //   },
  //   {
  //     'id': '12',
  //     'imagePath': 'assets/images/card3.png',
  //     'title': 'Product 2',
  //     'weight': '100kg',
  //     'price': '200tk',
  //     'buttonText': 'Add to cart',
  //     'onPressed': () {},
  //     'onFavoritePressed': () {}
  //   },
  //   {
  //     'id': '13',
  //     'imagePath': 'assets/images/card4.png',
  //     'title': 'Product 2',
  //     'weight': '100kg',
  //     'price': '200tk',
  //     'buttonText': 'Add to cart',
  //     'onPressed': () {},
  //     'onFavoritePressed': () {}
  //   },
  //   // Add more products here
  // ];

  final List<Map<String, dynamic>> eidproducts = [
    {
      'id': '20',
      'imagePath': 'assets/images/card1.png',
      'title': 'Orange (South Africa)',
      'weight': '1kg',
      'price': 245.0,
      'buttonText': 'Add to cart',
      'onPressed': () {},
      'onFavoritePressed': () {}
    },
    {
      'id': '21',
      'imagePath': 'assets/images/card2.png',
      'title': 'Gulsha Tengra (Medium)',
      'weight': '1kg',
      'price': 450.0,
      'buttonText': 'Add to cart',
      'onPressed': () {},
      'onFavoritePressed': () {}
    },
    {
      'id': '22',
      'imagePath': 'assets/images/card3.png',
      'title': 'Product 2',
      'weight': '100kg',
      'price': 200.0,
      'buttonText': 'Add to cart',
      'onPressed': () {},
      'onFavoritePressed': () {}
    },
    {
      'id': '23',
      'imagePath': 'assets/images/card4.png',
      'title': 'Product 2',
      'weight': '100kg',
      'price': 200.0,
      'buttonText': 'Add to cart',
      'onPressed': () {},
      'onFavoritePressed': () {}
    },
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    // final itemsProvider = Provider.of<ItemsProvider>(context);
    final PopularProducts = popularProducts.take(4).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.2, // Set the height of the CarouselSlider
              child: CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/slider_img.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/slider_img2.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  //2nd Image of Slider
                ],
                //Slider Container properties
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 23 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.95,
                ),
              ),
            ),
            Container(
              // color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the ProductsPage when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PopularPage()),
                      );
                    },
                    child: const Text(
                      'See More >',
                      style: TextStyle(
                          color: Color(0xFFB3B300),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: PopularProducts.length,
                itemBuilder: (context, index) {
                  final product = PopularProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCard(
                      id: product['id'],
                      imagePath: product['imagePath']!,
                      title: product['title']!,
                      weight: product['weight']!,
                      price: product['price'],
                      buttonText: product['buttonText']!,
                      onPressed: () {},
                      onFavoritePressed: () {
                        final favoritesProvider =
                            Provider.of<FavoritesProvider>(context,
                                listen: false);
                        favoritesProvider.addFavorite(product);
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              // color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Eid Special',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the ProductsPage when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EidspecialPage()),
                      );
                    },
                    child: const Text(
                      'See More >',
                      style: TextStyle(
                          color: Color(0xFFB3B300),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: eidproducts.length,
                itemBuilder: (context, index) {
                  final product = eidproducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCard(
                      id: product['id'],
                      imagePath: product['imagePath']!,
                      title: product['title']!,
                      weight: product['weight']!,
                      price: product['price'],
                      buttonText: product['buttonText']!,
                      onPressed: () {},
                      onFavoritePressed: () {
                        final favoritesProvider =
                            Provider.of<FavoritesProvider>(context,
                                listen: false);
                        favoritesProvider.addFavorite(product);
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Center(
                  child: Text(
                    'Shop by category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the Fruits & Vegetables category page
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/vegetables.png',
                                    width: 150, height: 150),
                                const SizedBox(height: 8),
                                const Text(
                                  'Fruits & Vegetables',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the Baby Care category page
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/baby_care.png',
                                    width: 150, height: 150),
                                const SizedBox(height: 8),
                                const Text(
                                  'Baby Care',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Space between the rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the Home & Cleaning category page
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/cleaning.png',
                                    width: 150, height: 150),
                                const SizedBox(height: 8),
                                const Text(
                                  'Home & Cleaning',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the Meat & Fish category page
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/meat.png',
                                    width: 150, height: 150),
                                const SizedBox(height: 8),
                                const Text(
                                  'Meat & Fish',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: 370,
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToCategories();
                    },
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFB3B300)),
                      backgroundColor: Colors.white, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 40.0), // Button padding
                    ),
                    child: const Text(
                      'VIEW ALL',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB3B300),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Inspired by your shopping',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the ProductsPage when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InspiredbyPage()),
                      );
                    },
                    child: const Text(
                      'See More >',
                      style: TextStyle(
                          color: Color(0xFFB3B300),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 325.0, // Set the height of the horizontal ListView
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ProductCard(
                    id: '31',
                    imagePath: 'assets/images/card1.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: 609,
                    buttonText: 'Add to cart',
                    onPressed: () {},
                    onFavoritePressed: () {},
                  ),
                  ProductCard(
                    id: '32',
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: 609,
                    buttonText: 'Add to cart',
                    onPressed: () {},
                    onFavoritePressed: () {},
                  ),
                  ProductCard(
                    id: '33',
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: 609,
                    buttonText: 'Add to cart',
                    onPressed: () {},
                    onFavoritePressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
