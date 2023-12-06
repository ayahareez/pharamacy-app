import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/data/models/Checkout_model.dart';
import 'package:pharmacy/medicine/presentation/pages/order_details_page.dart';

class HistoryGridTile extends StatelessWidget {
  final int index;
  final CheckoutModel checkoutModel;
  const HistoryGridTile(
      {super.key, required this.index, required this.checkoutModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffE2D2B8),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          'Order #${index + 1}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Date: ${checkoutModel.dateTime}',
          style: const TextStyle(fontSize: 16, color: Color(0xff43291f)),
        ), // Replace with actual date
        trailing: Text(
          'Total: ${checkoutModel.total}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ), // Replace with actual total
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderDetailsPage(
                        checkoutModel: checkoutModel,
                      )));
        },
      ),
    );
  }
}