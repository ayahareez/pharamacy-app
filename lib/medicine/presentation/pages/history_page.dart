import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of orders
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
                  'Date: ${DateTime.now().toString()}'), // Replace with actual date
              trailing: Text(
                'Total: 100 EGP',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CrimsonText-Regular',
                    fontWeight: FontWeight.bold),
              ), // Replace with actual total
              onTap: () {
                // Handle tapping on a specific order
                // You can navigate to a detailed order view or show more information.
              },
            ),
          );
        },
      ),
    );
  }
}