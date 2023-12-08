import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/data/models/Checkout_model.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';
import 'package:pharmacy/medicine/presentation/widgets/order_details_grid_tile.dart';

import '../bloc/checkout_bloc/checkout_bloc.dart';

class OrderDetailsPage extends StatefulWidget {
  final CheckoutModel checkoutModel;

  const OrderDetailsPage({super.key, required this.checkoutModel});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  // @override
  // void initState() {
  //   context.read<CheckoutBloc>().add(GetOrders());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          start: 8,
          end: 8,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${widget.checkoutModel.fullName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text('Email: ${widget.checkoutModel.email}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text('Phone: ${widget.checkoutModel.phoneNumber}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemBuilder: (_, i) => OrderDetailsGridTile(
                    cartModel: widget.checkoutModel.cartModels[i],
                  ),
                  itemCount: widget.checkoutModel.cartModels.length,
                ),
              ),
              const Spacer(),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text('Date Of Order :  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        Text('${widget.checkoutModel.dateTime}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18))
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Total :  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        Text('${widget.checkoutModel.total}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}