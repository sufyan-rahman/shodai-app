final List<Map<String, dynamic>> popularProducts = [
  {
    'id': '10',
    'imagePath': 'assets/images/card1.png',
    'title': 'Orange (South Africa)',
    'weight': '2kg',
    'price': 245.0,
    'buttonText': 'Add to cart',
    'description': 'Shodai is location based food and grocery service. You will find everything healthy and hygienic from our wide range of products category. You are able to order your desired products which will be delivered right to your doorstep. Sometimes it is not possible for you to shop necessary things just for lack of time. Shodai can take responsibility to complete your shopping task so that you can spend your time with your loved ones.'
  },
  {
    'id': '12',
    'imagePath': 'assets/images/card2.png',
    'title': 'Gulsha Tengra',
    'weight': '1kg',
    'price': 450.0,
    'buttonText': 'Add to cart',
    'description': 'Shodai is location based food and grocery service. You will find everything healthy and hygienic from our wide range of products category. You are able to order your desired products which will be delivered right to your doorstep. Sometimes it is not possible for you to shop necessary things just for lack of time. Shodai can take responsibility to complete your shopping task so that you can spend your time with your loved ones.'
  },
  {
    'id': '13',
    'imagePath': 'assets/images/card3.png',
    'title': 'Product 2',
    'weight': '100kg',
    'price': 300.0,
    'buttonText': 'Add to cart',
    'description': 'Shodai is location based food and grocery service. You will find everything healthy and hygienic from our wide range of products category. You are able to order your desired products which will be delivered right to your doorstep. Sometimes it is not possible for you to shop necessary things just for lack of time. Shodai can take responsibility to complete your shopping task so that you can spend your time with your loved ones.'
  },
  {
    'id': '14',
    'imagePath': 'assets/images/card4.png',
    'title': 'Product 3',
    'weight': '100kg',
    'price': 100.0,
    'buttonText': 'Add to cart',
    'description': 'dscdscds'
  },
  {
    'id': '15',
    'imagePath': 'assets/images/card5.png',
    'title': 'Nestle asd asdkjsd sdasdksd sdasd',
    'weight': '100kg',
    'price': 150.0,
    'buttonText': 'Add to cart',
    'description': 'dcjsncjnsdcj'
  },
  {
    'id': '16',
    'imagePath': 'assets/images/card6.png',
    'title': 'Nestle asd asdkjsd sdasdksd sdasd',
    'weight': '100kg',
    'price': 220.0,
    'buttonText': 'Add to cart',
    'description': 'dcjsncjnsdcj'
  },
  {
    'id': '17',
    'imagePath': 'assets/images/card7.png',
    'title': 'Nestle asd asdkjsd sdasdksd sdasd',
    'weight': '100kg',
    'price': 100.0,
    'buttonText': 'Add to cart',
    'description': 'dcjsncjnsdcj'
  },
  {
    'id': '18',
    'imagePath': 'assets/images/card8.png',
    'title': 'Nestle asd asdkjsd sdasdksd sdasd',
    'weight': '100kg',
    'price': 2500.0,
    'buttonText': 'Add to cart',
    'description': 'dcjsncjnsdcj'
  },
];

// // Function to add products to Firestore
// Future<void> addProductsToFirestore() async {
//   CollectionReference productsCollection =
//   FirebaseFirestore.instance.collection('popularProducts');
//
//   for (var product in popularProducts) {
//     await productsCollection.add(product).then((value) {
//       print("Product Added: ${value.id}");
//     }).catchError((error) {
//       print("Failed to add product: $error");
//     });
//   }
// }
