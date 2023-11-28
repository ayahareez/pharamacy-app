import 'package:flutter/material.dart';

class OngoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ongoing Orders',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: 3, // Replace with the actual number of ongoing orders
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xffE2D2B8),
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                'Order #${index + 1}',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CrimsonText-Regular',
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Expected Delivery: ${DateTime.now().add(Duration(days: 2)).toString()}'), // Replace with actual expected delivery date
              trailing: ElevatedButton(
                onPressed: () {
                  // Handle tapping on the button, for example, navigate to order details
                  // You can replace this with your specific logic
                  print('Order Details Button Pressed');
                },
                child: Text(
                  'Order Details',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEBE7DC)),
              ),
            ),
          );
        },
      ),
    );
  }
}