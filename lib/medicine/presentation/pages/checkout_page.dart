import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/medicine/data/models/Checkout_model.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';
import 'package:pharmacy/medicine/presentation/widgets/checkout_grid_tile.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/checkout_bloc/checkout_bloc.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartModel> cartModels;

  const CheckoutPage({Key? key, required this.cartModels}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  int total(List<CartModel> cartModels) {
    int total = 0;
    for (int i = 0; i < cartModels.length; i++) {
      total += cartModels[i].qty;
    }
    return total;
  }

  int price(List<CartModel> cartModels) {
    double total = 0;
    for (int i = 0; i < cartModels.length; i++) {
      for (int j = 0; j < cartModels[i].qty; j++) {
        total += cartModels[i].medicineModel.price;
      }
    }
    return total.toInt();
  }

  int theTotal = 0;

  int thePrice = 0;
  @override
  void initState() {
    theTotal = total(widget.cartModels);
    thePrice = price(widget.cartModels);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Quantity Column
                    Container(
                      width: 50,
                      child: const Text(
                        'QTY',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24), // Adjust the spacing as needed

                    // Product Name Column
                    const Expanded(
                      child: Text(
                        'ProductName',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Adjust the spacing as needed

                    // Price Column
                    Container(
                      width: 100,
                      child: const Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (var cartModel in widget.cartModels)
              CheckoutGridTile(cartModel: cartModel),
            const Spacer(),
            const Divider(
              thickness: 2,
              color: Color(0xffE2D2B8),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${thePrice} EGP',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _showOverlayPage(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xfff5e0c0),
                  primary: Colors.black,
                ),
                child: const Text(
                  'CONFIRM ORDER',
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'CrimsonText-Regular'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOverlayPage(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xffDFD7C4),
          title: const Center(
            child: Text(
              'Delivery details',
              style: TextStyle(color: Color(0xff201E1F)),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  int totalPrice = widget.cartModels.fold(0,
                      (sum, cartModel) => sum + cartModel.medicineModel.price);
                  DateTime now = DateTime.now();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd  HH:mm:ss').format(now);
                  CheckoutModel checkoutModel = CheckoutModel(
                      cartModels: widget.cartModels,
                      dateTime: formattedDate,
                      fullName: nameController.text,
                      phoneNumber: phoneController.text,
                      total: totalPrice);
                  context
                      .read<CheckoutBloc>()
                      .add(SetOrder(checkoutModel: checkoutModel));
                  Navigator.pop(context);
                  context.read<CartBloc>().add(DeleteCartsForUser());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff201E1F)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Color(0xffDFD7C4)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}