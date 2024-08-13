import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderConfirmedPage extends StatelessWidget {
  final String paymentMethod;
  final DateTime orderPlacedDate;
  final String orderNumber;
  final String preferredDeliveryTime;
  final String deliveryAddress;
  final String userName;
  final String userPhoneNumber;
  final double subtotal;
  final double deliveryFee;
  final double vat;
  final double discount;
  final double total;
  const OrderConfirmedPage({
    required this.paymentMethod,
    required this.orderPlacedDate,
    required this.orderNumber,
    required this.preferredDeliveryTime,
    required this.deliveryAddress,
    required this.userName,
    required this.userPhoneNumber,
    required this.subtotal,
    required this.deliveryFee,
    required this.vat,
    required this.discount,
    required this.total,
    super.key,
  });

  Future<void> _deleteOrder(BuildContext context) async {
    // Replace with your Firestore collection and document ID
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderNumber)
        .delete();
    // Navigate back to homepage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
    ); // Adjust the route name as necessary
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Order'),
          content: const Text('Would you like to cancel the order?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deleteOrder(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order no. $orderNumber'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.done,
                size: 50,
              ),
              const Text(
                'Thanks for your order!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your order was confirmed as $paymentMethod. We’re processing your order, here are the details',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Divider(),
              _buildOrderDetailsSection(),
              const SizedBox(height: 20),
              const Divider(),
              _buildOrderSummarySection(),
              const Divider(),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const Text('Would you like to cancel this order?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {
                        _showCancelDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Cancel Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailsSection() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildOrderDetailRow(
              'Order Placed:', dateFormat.format(orderPlacedDate)),
          _buildOrderDetailRow('Order Number:', orderNumber),
          _buildOrderDetailRow(
              'Preferred Delivery Time', preferredDeliveryTime),
          _buildOrderDetailRow('Delivery Address', deliveryAddress),
          _buildOrderDetailRow('Name', userName),
          _buildOrderDetailRow('Phone Number', userPhoneNumber),
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, height: 2.0),
            ),
            Text(
              '৳$subtotal',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Delivery Fee',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, height: 2.0),
            ),
            Text(
              '৳$deliveryFee',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'VAT',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, height: 2.0),
            ),
            Text(
              '৳$vat',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Discount',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, height: 2.0),
            ),
            Text(
              '- ৳$discount',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const Divider(thickness: 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'DUE TOTAL',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, height: 2.0),
            ),
            Text(
              '৳${total + vat}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDetailRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
