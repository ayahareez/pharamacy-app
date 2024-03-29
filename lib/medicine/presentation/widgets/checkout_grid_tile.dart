import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';

class CheckoutGridTile extends StatelessWidget {
  final CartModel cartModel;

  const CheckoutGridTile({Key? key, required this.cartModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Quantity Column
          SizedBox(
            width: 50,
            child: Text(
              ' ${cartModel.qty}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 24), // Adjust the spacing as needed

          // Product Name Column
          Expanded(
            child: Text(
              cartModel.medicineModel.productName,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16), // Adjust the spacing as needed

          // Price Column
          SizedBox(
            width: 100,
            child: Text(
              '${cartModel.medicineModel.price} EGP',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}