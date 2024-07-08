import 'package:ecom/add_new_address.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_address.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  _ManageAddressPageState createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  Future<List<Map<String, dynamic>>> _fetchAddresses() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final QuerySnapshot addressSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .get();
      return addressSnapshot.docs
          .map((doc) =>
              {'id': doc.id, 'data': doc.data() as Map<String, dynamic>})
          .toList();
    }
    return [];
  }

  Future<void> _deleteAddress(String addressId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .doc(addressId)
          .delete();
      setState(() {});
    }
  }

  Future<void> _addNewAddress() async {
    // Navigate to Add Address Page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewAddressPage()),
    ).then((_) => setState(() {}));
  }

  Future<void> _editAddress(
      String addressId, Map<String, dynamic> addressData) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAddressPage(
          addressId: addressId,
          addressData: addressData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Manage Addresses'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchAddresses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading addresses'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_outlined, size: 100),
                  Text(
                    'No Addresses yet',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Add an address so you can place your first order',
                    style: TextStyle(color: Colors.grey),
                  ),
                  // const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: _addNewAddress,
                  //   child: const Text('Add New Address'),
                  // ),
                ],
              ),
            );
          }

          final addresses = snapshot.data!;

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index]['data'];
              final addressId = addresses[index]['id'];
              return ListTile(
                title: Text(address['address'] ?? 'Address $index'),
                subtitle: Text(
                    '${address['area']}, ${address['city']}, ${address['zipCode']}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'Edit') {
                      // Navigate to Edit Address Page
                      _editAddress(addressId, address);
                    } else if (value == 'Delete') {
                      _deleteAddress(addressId);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewAddress,
        label: const Text('Add New Address'),
      ),
    );
  }
}
