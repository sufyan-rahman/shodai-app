import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'manage_address.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final double subtotal;
  final double deliveryFee;
  final double vat;
  final double discount;
  final double total;

  const CheckoutPage({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.vat,
    required this.discount,
    required this.total,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late String selectedDate;
  String selectedTime = '11AM - 12PM';
  String _selectedPaymentMethod = 'Cash on Delivery';
  String? selectedAddress;


  @override
  void initState() {
    super.initState();
    // Set selectedDate to three days after the present day
    DateTime today = DateTime.now();
    DateTime threeDaysFromNow = today.add(const Duration(days: 3));
    selectedDate = DateFormat('EEE, MMM d').format(threeDaysFromNow);
  }

  void _selectPaymentMethod(String? method) {
    setState(() {
      _selectedPaymentMethod = method!;
    });
  }

  void updateSelectedDate(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  void updateSelectedTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

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

  Future<void> _showAddressSelectionDialog() async {
    final addresses = await _fetchAddresses();
    if (addresses.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ManageAddressPage()),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Address'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index]['data'];
                return ListTile(
                  title: Text(address['address'] ?? 'Address $index'),
                  subtitle: Text(
                      '${address['area']}, ${address['city']}, ${address['zipCode']}'),
                  onTap: () {
                    setState(() {
                      selectedAddress = address['address'];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageAddressPage()),
                );
              },
              child: const Text('Manage Addresses'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
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
        title: const Text('Checkout'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                    title: Center(
                      child: Text(
                        selectedAddress ?? ' + Add Address',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: _showAddressSelectionDialog,
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
                    subtitle: Text(
                      '$selectedTime, $selectedDate',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => DeliveryTimePicker(
                          selectedDate: selectedDate,
                          selectedTime: selectedTime,
                          onDateSelected: updateSelectedDate,
                          onTimeSelected: updateSelectedTime,
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Order Notes (Optional)',
                    style: TextStyle(fontSize: 18, height: 2.0),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Write notes about your order',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                  const SizedBox(height: 20),
                  const Text('Order Summary',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  OrderSummaryRow(
                      label: 'Subtotal',
                      value: '৳${widget.subtotal.toStringAsFixed(2)}'),
                  OrderSummaryRow(
                      label: 'Delivery Fee',
                      value: '৳${widget.deliveryFee.toStringAsFixed(2)}'),
                  OrderSummaryRow(
                      label: 'Vat (Tax)',
                      value: '৳${widget.vat.toStringAsFixed(2)}'),
                  OrderSummaryRow(
                      label: 'Discount',
                      value: '৳${widget.discount.toStringAsFixed(2)}',
                      valueColor: Colors.red),
                  const Divider(thickness: 1.5),
                  OrderSummaryRow(
                      label: 'TOTAL',
                      value:
                          '৳${(widget.total + widget.vat).toStringAsFixed(2)}',
                      isBold: true),
                  const SizedBox(height: 20),
                  const Text('Payment Method',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  RadioListTile<String>(
                    title: const Text('Cash on Delivery'),
                    value: 'Cash on Delivery',
                    groupValue: _selectedPaymentMethod,
                    onChanged: _selectPaymentMethod,
                    activeColor: const Color(0xFF999900),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  RadioListTile<String>(
                    title: const Text('Digital Payment'),
                    value: 'Digital Payment',
                    groupValue: _selectedPaymentMethod,
                    onChanged: _selectPaymentMethod,
                    activeColor: const Color(0xFF999900),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
    );
  }
}

class DeliveryTimePicker extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final ValueChanged<String> onDateSelected;
  final ValueChanged<String> onTimeSelected;

  const DeliveryTimePicker({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  _DeliveryTimePickerState createState() => _DeliveryTimePickerState();
}



class _DeliveryTimePickerState extends State<DeliveryTimePicker> {
  late String _selectedDate;
  late String _selectedTime;
  late List<DateTime> _next7Days;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedTime = widget.selectedTime;
    _next7Days = _generateNext7Days();
  }

  List<DateTime> _generateNext7Days() {
    final today = DateTime.now();
    return List<DateTime>.generate(7, (i) => today.add(Duration(days: i + 1)));
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date); // e.g., Tue, Jul 10
  }

  void _selectDate(String date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
    widget.onTimeSelected(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Schedule Delivery Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          const Text('Pick a delivery date'),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _next7Days.map((date) {
                String formattedDate = _formatDate(date);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: _DateButton(
                    label: formattedDate,
                    isSelected: _selectedDate == formattedDate,
                    onPressed: () => _selectDate(formattedDate),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Pick a delivery time'),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TimeButton(
                  label: '11AM - 12PM',
                  isSelected: _selectedTime == '11AM - 12PM',
                  onPressed: () => _selectTime('11AM - 12PM'),
                ),
                const SizedBox(width: 10.0),
                _TimeButton(
                  label: '12PM - 1PM',
                  isSelected: _selectedTime == '12PM - 1PM',
                  onPressed: () => _selectTime('12PM - 1PM'),
                ),
                const SizedBox(width: 10.0),
                _TimeButton(
                  label: '1PM - 2PM',
                  isSelected: _selectedTime == '1PM - 2PM',
                  onPressed: () => _selectTime('1PM - 2PM'),
                ),
                const SizedBox(width: 10.0),
                _TimeButton(
                  label: '2PM - 3PM',
                  isSelected: _selectedTime == '2PM - 3PM',
                  onPressed: () => _selectTime('2PM - 3PM'),
                ),
                const SizedBox(width: 10.0),
                _TimeButton(
                  label: '3PM - 4PM',
                  isSelected: _selectedTime == '3PM - 4PM',
                  onPressed: () => _selectTime('3PM - 4PM'),
                ),
                const SizedBox(width: 10.0),
                _TimeButton(
                  label: '4PM - 5PM',
                  isSelected: _selectedTime == '4PM - 5PM',
                  onPressed: () => _selectTime('4PM - 5PM'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              elevation: 0,
              backgroundColor: const Color(0xFF999900),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _DateButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _DateButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 24.0),
        backgroundColor: isSelected ? const Color(0xFF999900) : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(
                color: Colors.black, width: 1.0, style: BorderStyle.solid)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(color: isSelected ? Colors.white : null),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _TimeButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 24.0),
        backgroundColor: isSelected ? const Color(0xFF999900) : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(
                color: Colors.black, width: 1.0, style: BorderStyle.solid)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(color: isSelected ? Colors.white : null),
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
