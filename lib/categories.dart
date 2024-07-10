import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // Define a list of categories with their respective images and items
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Grocery',
      'imagePath': 'assets/images/vegetables.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Meat & Fish',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Fruits & Vegetable',
      'imagePath': 'assets/images/vegetables.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Bakery',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Dairy',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Beverages',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Snacks',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Snacks',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Snacks',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
    {
      'title': 'Diaper',
      'imagePath': 'assets/images/meat.png',
      'items': ['Item 1', 'Item 2', 'Item 3']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 2.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Color(0xFFE8EAEC),
                    ))),
                    child: ExpansionTile(
                      leading: Image.asset(category['imagePath'],
                          width: 80, height: 80),
                      title: Text(
                        category['title'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      children: (category['items'] as List<String>).map((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            // Item tapped
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
