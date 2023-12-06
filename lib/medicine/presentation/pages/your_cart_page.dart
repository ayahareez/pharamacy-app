import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/presentation/pages/checkout_page.dart';
import 'package:pharmacy/medicine/presentation/pages/contoller_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/your_cart_grid_tile.dart';

import '../../data/models/cart_model.dart';
import '../bloc/cart_bloc/cart_bloc.dart';

class YourCartPage extends StatefulWidget {
  const YourCartPage({super.key});

  @override
  State<YourCartPage> createState() => _YourCartPageState();
}

class _YourCartPageState extends State<YourCartPage> {
  bool cartFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!cartFetched) {
      context.read<CartBloc>().add(GetCart());
      cartFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart',
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          print(state);
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartLoaded) {
            int theTotal = total(state.cartModels);
            int thePrice = price(state.cartModels);
            return Padding(
              padding: const EdgeInsetsDirectional.all(8),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  ListView.separated(
                    itemBuilder: (_, i) => YourCartGridTile(
                      cartModel: state.cartModels[i],
                    ),
                    itemCount: state.cartModels.length,
                    separatorBuilder: (_, i) => const SizedBox(
                      height: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${theTotal}',
                              style: const TextStyle(
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
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckoutPage(
                                            cartModels: state.cartModels,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfff5e0c0),
                              foregroundColor: Colors.black,
                            ),
                            child: const Text(
                              'PROCEED TO CHECKOUT',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

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
}