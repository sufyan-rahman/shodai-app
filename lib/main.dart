import 'package:ecom/more.dart';
import 'package:ecom/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/cart_controller.dart';
import 'items_page.dart';
import 'categories.dart';
import 'home.dart';
import 'deals.dart';
import 'product_firestore.dart';
import 'product_list_data/popular_products.dart';
import 'shopping_cart.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await addOrUpdateProductsInFirestore('popularProducts', popularProducts);
  // await addOrUpdateProductsInFirestore('eidProducts', eidcards);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _navigateToCategories() {
    setState(() {
      _selectedIndex = 1; // Categories is at index 1
    });
  }

  static List<Widget> _widgetOptions(VoidCallback navigateToCategories) =>
      <Widget>[
        Home(navigateToCategories: navigateToCategories),
        const CategoriesPage(),
        const DealsPage(),
         ItemsPage(),
        const MorePage(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 4
          ? null
          : AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  icon: Image.asset('assets/logo.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  },
                ),
              ),
              title:  ElevatedButton(
                onPressed: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Search Product...',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),

        actions: [
                // IconButton(
                //   icon: SizedBox(
                //     width: 24,
                //     height: 24,
                //     child: Image.asset('assets/icons/cart.png'),
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => ShoppingCartPage()));
                //   },
                // ),
                Obx(
                  () => Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset('assets/icons/cart.png'),
                          // child: Icon(Icons.shopping_cart)
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShoppingCartPage(),
                            ),
                          );
                        },
                      ),
                      if (cartController.totalItems > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${cartController.totalItems}',
                              style: const TextStyle(
                                // color: Colors.black,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              backgroundColor: const Color(0xFF7D7D00),
              toolbarHeight: 70.0,
            ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions(_navigateToCategories),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Deals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF7D7D00),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
