import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/data/models/Checkout_model.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';

// class OrderDetailsGridTile extends StatelessWidget {
//   final CartModel cartModel;
//
//   const OrderDetailsGridTile({super.key, required this.cartModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: [
//           Image.asset('${cartModel.medicineModel.imageUrl}'),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Text('Quantity: '),
//                   Spacer(),
//                   Text('${cartModel.qty}')
//                 ],
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 children: [
//                   Text('Price Per Item: '),
//                   Spacer(),
//                   Text('${cartModel.medicineModel.price}')
//                 ],
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 children: [
//                   Text('Product Description: '),
//                   Spacer(),
//                   Text('${cartModel.medicineModel.description}')
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class OrderDetailsGridTile extends StatelessWidget {
  final CartModel cartModel;

  const OrderDetailsGridTile({Key? key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xffE2D2B8), borderRadius: BorderRadius.circular(16)),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(child: Image.asset('${cartModel.medicineModel.imageUrl}')),
            SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text('Quantity: ',
                              style: TextStyle(
                                  fontFamily: 'CrimsonText-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18))),
                      Expanded(
                          child: Text('${cartModel.qty}',
                              style: TextStyle(
                                  fontFamily: 'CrimsonText-Regular',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16)))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text('Price Per Item: ',
                              style: TextStyle(
                                  fontFamily: 'CrimsonText-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18))),
                      Expanded(
                          child: Text('${cartModel.medicineModel.price}',
                              style: TextStyle(
                                  fontFamily: 'CrimsonText-Regular',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16)))
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text('Product Description: ',
                              style: TextStyle(
                                  fontFamily: 'CrimsonText-Regular',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18))),
                      Expanded(
                          child: Text('${cartModel.medicineModel.description}',
                              style: TextStyle(
                                  fontFamily: 'CrimsonText-Regular',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16)))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}