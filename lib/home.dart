import 'package:ecom/eidspecial.dart';
import 'package:ecom/inspiredby.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'popular.dart';
import 'package:ecom/widgets/productcard.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'Categories',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'Deals',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'My Items',
      style: TextStyle(fontSize: 24),
    ),
    Text(
      'More',
      style: TextStyle(fontSize: 24),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
        ),
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search Product...',
            suffixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(21.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(21.0)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          ),
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/cart.png'),
            ),
            onPressed: () {
              // Define what happens when the button is pressed
              if (kDebugMode) {
                print('Button with image pressed');
              }
            },
          ),
        ],
        backgroundColor: const Color(0xFF7D7D00),
        toolbarHeight: 70.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 180.0, // Set the height of the CarouselSlider
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
            Padding(
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
                        MaterialPageRoute(
                            builder: (context) => const PopularPage()),
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
                    imagePath: 'assets/images/card1.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  ProductCard(
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  ProductCard(
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  // buildCard(
                  //   imagePath: 'assets/images/card1.png',
                  //   title: 'Danish Full Cream Milk Powder',
                  //   weight: '1 kg',
                  //   price: 'Tk. 1200',
                  //   buttonText: 'Add to Cart',
                  //   onPressed: (){},
                  // ),
                  // buildCard(
                  //   imagePath: 'assets/images/card2.png',
                  //   title: 'Nescafe Gold Jar Coffee',
                  //   weight: '1 kg',
                  //   price: 'Tk. 1200',
                  //   buttonText: 'Add to Cart',
                  //   onPressed: (){},
                  // ),
                  // buildCard(
                  //   imagePath: 'assets/images/card2.png',
                  //   title: 'Nescafe Gold Jar Coffee',
                  //   weight: '1 kg',
                  //   price: 'Tk. 1200',
                  //   buttonText: 'Add to Cart',
                  //   onPressed: (){},
                  // ),
                  // Add more cards here as needed
                ],
              ),
            ),
            Padding(
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
                    imagePath: 'assets/images/card1.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  ProductCard(
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  ProductCard(
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                ],
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
                    imagePath: 'assets/images/card1.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  ProductCard(
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                  ProductCard(
                    imagePath: 'assets/images/card2.png',
                    title: 'Danish Full Cream Milk Powder',
                    weight: '1 Kg',
                    price: '৳609',
                    buttonText: 'Add to cart',
                    onPressed: () {
                      // Add to cart action
                    },
                  ),
                ],
              ),
            ),


          ],
        ),
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
        selectedItemColor: Color(0xFF7D7D00),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

}

