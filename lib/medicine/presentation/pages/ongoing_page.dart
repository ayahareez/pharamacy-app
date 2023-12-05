import 'package:flutter/material.dart';

class OngoingPage extends StatelessWidget {
  const OngoingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ongoing Orders',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: 3, // Replace with the actual number of ongoing orders
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xffE2D2B8),
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                'Order #${index + 1}',
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'CrimsonText-Regular',
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Expected Delivery: ${DateTime.now().add(const Duration(days: 2)).toString()}'), // Replace with actual expected delivery date
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle tapping on the button, for example, navigate to order details
                  // You can replace this with your specific logic
                  print('Order Details Button Pressed');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffEBE7DC)),
                child: const Text(
                  'Order Details',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}