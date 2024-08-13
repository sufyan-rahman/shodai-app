import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addOrUpdateProductsInFirestore(
    String collectionName, List<Map<String, dynamic>> productList) async {
  CollectionReference productsCollection =
  FirebaseFirestore.instance.collection(collectionName);

  QuerySnapshot querySnapshot = await productsCollection.get();
  Map<String, DocumentSnapshot> existingProducts = {
    for (var doc in querySnapshot.docs) doc['id']: doc
  };

  for (var product in productList) {
    String productId = product['id'];

    if (existingProducts.containsKey(productId)) {
      // Product exists, check if details are different
      var existingProduct = existingProducts[productId];
      bool needsUpdate = false;

      // Compare each field (excluding id)
      for (var key in product.keys) {
        if (key != 'id' && existingProduct![key] != product[key]) {
          needsUpdate = true;
          break;
        }
      }

      if (needsUpdate) {
        // Update the product details in Firestore
        await productsCollection
            .doc(productId)
            .set(product, SetOptions(merge: true))
            .then((value) {
          print("Product Updated: $productId");
        }).catchError((error) {
          print("Failed to update product: $error");
        });
      } else {
        print("No changes for product: $productId");
      }
    } else {
      // Add new product to Firestore with the specified productId
      await productsCollection
          .doc(productId)
          .set(product)
          .then((value) {
        print("Product Added: $productId");
      }).catchError((error) {
        print("Failed to add product: $error");
      });
    }
  }
}
