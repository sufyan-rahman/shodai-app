import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/items_provider.dart';
import 'widgets/productcard.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteItems = favoritesProvider.favorites;

    return Scaffold(

      body: favoriteItems.isEmpty
          ? const Center(child: Text('No favorite items.'))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: favoriteItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  final product = favoriteItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ProductCard(
                        imagePath: product['imagePath'],
                        title: product['title'],
                        weight: product['weight'],
                        price: product['price'],
                        buttonText: product['buttonText'],
                        onPressed: () {},
                        onFavoritePressed: (){favoritesProvider.removeFavorite(product);},),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
