import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';
import 'package:pharmacy/medicine/data/models/product_model.dart';

import '../bloc/cart_bloc/cart_bloc.dart';

class YourCartGridTile extends StatefulWidget {
  final CartModel cartModel;

  const YourCartGridTile({super.key, required this.cartModel});

  @override
  State<YourCartGridTile> createState() => _YourCartGridTileState();
}

class _YourCartGridTileState extends State<YourCartGridTile> {
  int qty = 0;
  CartModel? cartModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        print(state);
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          for (int i = 0; i < state.cartModels.length; i++) {
            if (state.cartModels[i].medicineModel.productId ==
                widget.cartModel.medicineModel.productId) {
              qty = state.cartModels[i].qty;
              cartModel = state.cartModels[i];
            }
          }
          return Row(
            children: [
              Expanded(
                  child: Container(
                height: 120,
                padding: const EdgeInsetsDirectional.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  color: Colors.white,
                ),
                child: Image.asset(
                  widget.cartModel.medicineModel.imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    color: Color(0xffE2D2B8),
                  ),
                  padding: const EdgeInsetsDirectional.only(
                      start: 8, bottom: 8, top: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cartModel.medicineModel.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${widget.cartModel.medicineModel.price} EGP',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          InkWell(
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.remove,
                                  size: 24,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (qty <= 0) {
                                    qty = 0;
                                    for (int i = 0;
                                        i < state.cartModels.length;
                                        i++) {
                                      if (state.cartModels[i].medicineModel
                                              .productId ==
                                          widget.cartModel.medicineModel
                                              .productId) {
                                        state.cartModels[i].qty = qty;
                                      }
                                    }
                                  } else
                                    qty--;
                                  for (int i = 0;
                                      i < state.cartModels.length;
                                      i++) {
                                    if (state.cartModels[i].medicineModel
                                            .productId ==
                                        widget.cartModel.medicineModel
                                            .productId) {
                                      state.cartModels[i].qty = qty;
                                    }
                                  }
                                  //cartModel!.qty = qty;
                                });
                                if (qty == 0) {
                                  context.read<CartBloc>().add(DeleteCart(
                                      cartModel: cartModel ??
                                          CartModel(
                                              qty: qty,
                                              medicineModel: widget
                                                  .cartModel.medicineModel,
                                              userId: '',
                                              id: '')));
                                } else {
                                  context.read<CartBloc>().add(UpdateCart(
                                      cartModel: cartModel ??
                                          CartModel(
                                              qty: qty,
                                              medicineModel: widget
                                                  .cartModel.medicineModel,
                                              userId: '',
                                              id: '')));
                                }
                              }),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            '${widget.cartModel.qty}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 16,
                              child: Icon(
                                Icons.add,
                                size: 24,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                qty++;
                                print(qty);
                                cartModel!.qty = qty;
                              });

                              if (qty == 1) {
                                context.read<CartBloc>().add(SetCart(
                                    cartModel: cartModel ??
                                        CartModel(
                                            qty: qty,
                                            medicineModel:
                                                widget.cartModel.medicineModel,
                                            userId: '',
                                            id: '')));
                                print(qty);
                              } else {
                                context.read<CartBloc>().add(UpdateCart(
                                    cartModel: cartModel ??
                                        CartModel(
                                            qty: qty,
                                            medicineModel:
                                                widget.cartModel.medicineModel,
                                            userId: '',
                                            id: '')));
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      cartModel!.qty = newQuantity;
      print(cartModel!.qty);
    });

    if (newQuantity == 0) {
      context.read<CartBloc>().add(DeleteCart(cartModel: widget.cartModel));
    } else {
      context.read<CartBloc>().add(UpdateCart(cartModel: widget.cartModel));
    }
  }
}