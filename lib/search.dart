import 'package:ecom/product_description.dart';
import 'package:ecom/product_list_data/eidspecial_products.dart';
import 'package:ecom/product_list_data/inspiredby_products.dart';
import 'package:ecom/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'product_list_data/popular_products.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final CartController cartController = Get.put(CartController());
    // Combine products from multiple sources
    List<Map<String, dynamic>> allProducts = [
      ...popularProducts,
      ...inspiredProducts,
      ...eidproducts,
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
              hintText: 'Search product, brands...',
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Color(0xFFF2F3F5),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              )),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
        toolbarHeight: 70.0,
        // backgroundColor: const Color(0xFF7D7D00),
      ),
      body: searchText.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'We have all your needs!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20, height: 2.0),
                  ),
                  Text('Search for products, brands and more')
                ],
              ),
            )
          : filteredProducts.isEmpty
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
