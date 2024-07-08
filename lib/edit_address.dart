import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditAddressPage extends StatefulWidget {
  final String addressId;
  final Map<String, dynamic> addressData;

  const EditAddressPage({super.key, required this.addressId, required this.addressData});

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController _cityController;
  late TextEditingController _addressController;
  late TextEditingController _zipcodeController;
  String? _selectedArea;
  final _formKey = GlobalKey<FormState>();

  final List<String> deliveryAreas = [
    'Mohammadpur',
    'Dhanmondi',
    'Mirpur',
    'Bashundhara',
    'Uttara',
    // Add more areas as needed
  ];

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.addressData['city']);
    _selectedArea = widget.addressData['area'];
    _addressController = TextEditingController(text: widget.addressData['address']);
    _zipcodeController = TextEditingController(text: widget.addressData['zipCode']);
  }

  Future<void> _updateAddress() async {
    if (_formKey.currentState!.validate()) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('addresses')
            .doc(widget.addressId)
            .update({
          'city': _cityController.text,
          'area': _selectedArea,
          'address': _addressController.text,
          'zipCode': _zipcodeController.text,
        });
        Navigator.pop(context); // Go back to the previous page
      }
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _addressController.dispose();
    _zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('City'),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              const Text('Delivery Area'),
              DropdownButtonFormField<String>(
                value: _selectedArea,
                onChanged: (newValue) {
                  setState(() {
                    _selectedArea = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a delivery area';
                  }
                  return null;
                },
                items: deliveryAreas.map((area) {
                  return DropdownMenuItem(
                    value: area,
                    child: Text(area),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('Address'),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              const Text('Post/Zip Code'),
              TextFormField(
                controller: _zipcodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the zip code';
                  }
                  return null;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _updateAddress,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF999900),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
