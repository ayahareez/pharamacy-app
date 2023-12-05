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
        title: const Text('Order Details',
            style: TextStyle(
                fontFamily: 'CrimsonText-Regular',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Text('${widget.checkoutModel.fullName}\'s Orders',
                  style: TextStyle(
                      fontFamily: 'CrimsonText-Regular',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 22)),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemBuilder: (_, i) => OrderDetailsGridTile(
                    cartModel: widget.checkoutModel.cartModels[i],
                  ),
                  itemCount: widget.checkoutModel.cartModels.length,
                ),
              ),
              Spacer(),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Date Of Order :  ',
                            style: TextStyle(
                                fontFamily: 'CrimsonText-Regular',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22)),
                        Text('${widget.checkoutModel.dateTime}',
                            style: TextStyle(
                                fontFamily: 'CrimsonText-Regular',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Total :  ',
                            style: TextStyle(
                                fontFamily: 'CrimsonText-Regular',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22)),
                        Text('${widget.checkoutModel.total}',
                            style: TextStyle(
                                fontFamily: 'CrimsonText-Regular',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18))
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