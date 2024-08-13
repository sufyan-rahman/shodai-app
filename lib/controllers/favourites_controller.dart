

import 'package:get/get.dart';
import '../models/cart_model.dart';

class FavoritesController extends GetxController {
  // List to store favorite items
  var favoriteItems = <CartItem>[].obs;

  // Method to add an item to favorites
  void addItem(CartItem item) {
    favoriteItems.add(item);
  }

  // Method to remove an item from favorites by id
  void removeItem(String id) {
    favoriteItems.removeWhere((item) => item.id == id);
  }
}
