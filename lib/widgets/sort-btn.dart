import 'dart:ui';

import 'package:flutter/material.dart';

class SortFilterBottomSheet extends StatefulWidget {
  const SortFilterBottomSheet({super.key});
  @override
  _SortFilterBottomSheetState createState() => _SortFilterBottomSheetState();
}

class _SortFilterBottomSheetState extends State<SortFilterBottomSheet> {
  int _sortByValue = -1; // Default value for "Newest"
  Map<String, bool> _selectedCategories = {
    'Fruits & Vegetable (2,031)': false,
    'Baby Care (7,210)': false,
    'Household & Cleaning': false,
    'Meat & Fish': false,
    'Stationary': false,
    'Personal Care': false,
    'Grocery': false,
    'Beverages': false,
    'Bakery': false,
    'Dairy': false,
    'Snacks': false,
    'Safe Food': false,
  };
  int _priceRangeValue = 2; // Default value for "৳ 100 - ৳ 200"

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            // Divider(),
            _buildSortBySection(),
            // Divider(),
            _buildCategoriesSection(),
            // Divider(),
            _buildPriceSection(),
            const SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 48), // Placeholder to balance the title
          const Text(
            'Sort & Filters',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSortBySection() {
    return ExpansionTile(
      title: const Text('Sort by'),
      children: [
        RadioListTile(
          title: const Text('Highest Rating'),
          value: 1,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Newest'),
          value: 2,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Lowest Price'),
          value: 3,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Best Seller'),
          value: 4,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return ExpansionTile(
      title: const Text('Categories'),
      children: [
        RadioListTile(
          title: const Text('Fruits and Vegetables'),
          value: 1,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Baby Care'),
          value: 2,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Household & Cleaning'),
          value: 3,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Meat & Fish'),
          value: 4,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Stationary'),
          value: 5,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Personal Care'),
          value: 6,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Grocery'),
          value: 7,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Beverages'),
          value: 8,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Bakery'),
          value: 9,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Dairy'),
          value: 10,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Snacks'),
          value: 11,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('Safe Food'),
          value: 12,
          groupValue: _sortByValue,
          onChanged: (value) {
            setState(() {
              _sortByValue = value!;
            });
          },
        ),

        // Add more categories as per the image
      ],
    );
  }

  Widget _buildPriceSection() {
    return ExpansionTile(
      title: const Text('Price'),
      children: [
        RadioListTile(
          title: const Text('৳ 0 - ৳ 100'),
          value: 1,
          groupValue: _priceRangeValue,
          onChanged: (value) {
            setState(() {
              _priceRangeValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('৳ 100 - ৳ 200'),
          value: 2,
          groupValue: _priceRangeValue,
          onChanged: (value) {
            setState(() {
              _priceRangeValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text('৳ 200+'),
          value: 3,
          groupValue: _priceRangeValue,
          onChanged: (value) {
            setState(() {
              _priceRangeValue = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF7D7D00),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100.0),
          ),
          child: const Text(
            'Apply',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _sortByValue = -1; // Clear selection
              _selectedCategories.updateAll((key, value) => false);
              _priceRangeValue = -1; // Clear selection
            });
          },
          child: const Text(
            'Clear',
            style: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
