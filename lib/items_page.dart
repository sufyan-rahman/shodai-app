import 'package:ecom/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favourites_controller.dart';

class ItemsPage extends StatelessWidget {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());

  ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (favoritesController.favoriteItems.isEmpty) {
          return const Center(
            child: Text('No favorite items.'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: favoritesController.favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoritesController.favoriteItems[index];
            return ProductCard(
              id: item.id,
              imagePath: item.imagePath,
              title: item.title,
              weight: item.weight,
              price: item.price,
              buttonText: 'Add to Cart',
              onPressed: () {
                favoritesController.removeItem(item.id);
              },
            );
          },
        );
      }),
    );
  }
}
