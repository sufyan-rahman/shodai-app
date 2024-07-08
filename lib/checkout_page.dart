import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, height: 2.0),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Add Address'),
                ],
              ),
              onTap: () {
                // Add your address adding functionality here
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Preferred Delivery Timing',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, height: 2.0),
            ),
            ListTile(
              title: const Text('Standard Delivery'),
              subtitle: const Text(
                '11:00 AM - 12:00 PM, Mon, July 10',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Add your delivery timing selection functionality here
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Notes (Optional)',
              style: TextStyle(
                 fontSize: 18, height: 2.0),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Write notes about your order',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            const Text('Order Summary',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            OrderSummaryRow(label: 'Subtotal', value: '৳590'),
            OrderSummaryRow(label: 'Delivery Fee', value: '৳50'),
            OrderSummaryRow(label: 'Vat (Tax)', value: '৳10'),
            OrderSummaryRow(
                label: 'Discount', value: '৳-50', valueColor: Colors.red),
            const Divider(thickness: 1.5),
            OrderSummaryRow(label: 'TOTAL', value: '৳640.50', isBold: true),
            const SizedBox(height: 20),
            const Text('Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            PaymentMethodTile(
              title: 'Cash on Delivery',
              icon: Icons.check_circle,
              iconColor: Colors.green,
              onTap: () {
                // Add your payment method selection functionality here
              },
            ),
            PaymentMethodTile(
              title: 'Digital Payment',
              icon: Icons.radio_button_unchecked,
              onTap: () {
                // Add your payment method selection functionality here
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your order confirmation functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF999900),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text('Confirm Order',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool isBold;

  const OrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = Colors.black,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = Colors.grey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon, color: iconColor),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: CheckoutPage(),
  ));
}
