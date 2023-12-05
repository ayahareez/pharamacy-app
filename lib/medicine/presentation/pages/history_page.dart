import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/remote_db_handler.dart';
import 'package:pharmacy/medicine/data/data_source/checkout_remote_ds.dart';
import 'package:pharmacy/medicine/presentation/widgets/history_grid_tile.dart';

import '../bloc/checkout_bloc/checkout_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<CheckoutBloc>().add(GetOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CheckoutLoaded) {
            return ListView.builder(
              itemCount: state.checkoutModels
                  .length, // Replace with the actual number of orders
              itemBuilder: (context, index) => HistoryGridTile(
                  index: index, checkoutModel: state.checkoutModels[index]),
            );
          }
          return SizedBox(
            child: Text('error'),
          );
        },
      ),
    );
  }
}