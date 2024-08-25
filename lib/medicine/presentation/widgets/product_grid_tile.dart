import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/data/models/product_model.dart';
import 'package:pharmacy/medicine/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:pharmacy/medicine/presentation/pages/product_info_page.dart';

import '../../data/models/cart_model.dart';
import '../bloc/medicine_bloc/product_bloc.dart';

class ProductGridTile extends StatefulWidget {
  final ProductModel medicineModel;

  const ProductGridTile({super.key, required this.medicineModel});

  @override
  State<ProductGridTile> createState() => _ProductGridTileState();
}

class _ProductGridTileState extends State<ProductGridTile> {
  late CartModel cartModel = CartModel(
      qty: 0, medicineModel: widget.medicineModel, userId: '', id: '');
  bool cartFetched = false;
  String? userId;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!cartFetched) {
  //     print('mmmmmmmmmm');
  //     context.read<CartBloc>().add(GetCart());
  //     cartFetched = true;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    final User? user = FirebaseAuth.instance.currentUser;
    userId = user != null ? user.uid : '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductInfoPage(productModel: widget.medicineModel)));
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          // if (state is CartLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }
          if (state is CartLoaded) {
            cartModel = state.cartModels.firstWhere(
                (element) =>
                    element.medicineModel.productId ==
                        widget.medicineModel.productId &&
                    element.userId == userId,
                orElse: () => CartModel(
                    qty: 0,
                    medicineModel: widget.medicineModel,
                    userId: '',
                    id: ''));
            return ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: GridTile(
                  footer: Container(
                    padding: const EdgeInsetsDirectional.all(8),
                    height: 65,
                    color: const Color(0xffE2D2B8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.medicineModel.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[900],
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.medicineModel.price} EGP',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              cartModel.qty == 0 ? ' ' : '${cartModel.qty}',
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (cartModel.qty != 0) {
                                      cartModel.qty--;
                                    }
                                  });
                                  if (cartModel.qty == 0) {
                                    context
                                        .read<CartBloc>()
                                        .add(DeleteCart(cartModel: cartModel));
                                  } else {
                                    context
                                        .read<CartBloc>()
                                        .add(UpdateCart(cartModel: cartModel));
                                  }
                                },
                                child: const Icon(
                                    Icons.remove_shopping_cart_outlined)),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    cartModel.qty++;
                                  });

                                  if (cartModel.qty == 1) {
                                    context
                                        .read<CartBloc>()
                                        .add(SetCart(cartModel: cartModel));
                                    // print(qty);
                                  } else {
                                    context
                                        .read<CartBloc>()
                                        .add(UpdateCart(cartModel: cartModel));
                                  }
                                },
                                child: const Icon(Icons.add_shopping_cart)),
                          ],
                        )
                      ],
                    ),
                  ),
                  child: Container(
                      color: Colors.white,
                      padding: const EdgeInsetsDirectional.all(24),
                      child: Image.asset(widget.medicineModel.imageUrl))),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}