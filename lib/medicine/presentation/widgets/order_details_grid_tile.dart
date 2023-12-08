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

  const OrderDetailsGridTile({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8, top: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color(0xffE2D2B8),
            borderRadius: BorderRadius.circular(16)),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(child: Image.asset(cartModel.medicineModel.imageUrl)),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text('Product Name: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18))),
                      Expanded(
                          child: Text('${cartModel.medicineModel.productName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text('Quantity: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18))),
                      Expanded(
                          child: Text('${cartModel.qty}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text('Price Per Item: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18))),
                      Expanded(
                          child: Text('${cartModel.medicineModel.price} EGP',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16)))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          flex: 2,
                          child: Text('Product Description: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18))),
                      Expanded(
                          child: Center(
                        child: Text(cartModel.medicineModel.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                      ))
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