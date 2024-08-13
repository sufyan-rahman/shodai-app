import 'package:ecom/controllers/cart_controller.dart';
import 'package:ecom/product_description.dart';
import 'package:ecom/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_list_data/popular_products.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    // final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // Combine products from multiple sources
    List<Map<String, dynamic>> allProducts = [
      ...popularProducts,
      // ...inspirecards,
      // ...eidcards,
      // ...dealcards,
      // ...babycards, // Add other product lists here
      // ...moreProductList,
    ];

    // Filter products based on search text
    List<Map<String, dynamic>> filteredProducts = allProducts
        .where((product) =>
            product['title'].toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search Product...',
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No products found.'))
          : GridView.builder(
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

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
                    ));
              },
            ),
    );
  }
}
