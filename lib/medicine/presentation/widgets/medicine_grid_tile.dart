import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/data/models/medicine_model.dart';

import '../../data/models/cart_model.dart';

class MedicineGridTile extends StatefulWidget {
  final CartModel cartModel;

  const MedicineGridTile({super.key, required this.cartModel});

  @override
  State<MedicineGridTile> createState() => _MedicineGridTileState();
}

class _MedicineGridTileState extends State<MedicineGridTile> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GridTile(
            footer: Container(
              padding: EdgeInsetsDirectional.all(8),
              height: 65,
              color: Color(0xffE2D2B8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.cartModel.medicineModel.productName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                        fontFamily: 'CrimsonText-Regular'),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.cartModel.medicineModel.price}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'CrimsonText-Regular'),
                      ),
                      Spacer(),
                      Text(
                        '${widget.cartModel.qty}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'CrimsonText-Regular'),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (count <= 0) {
                                count = 0;
                              } else
                                count--;
                              widget.cartModel.qty = count;
                            });
                          },
                          child: Icon(Icons.remove_shopping_cart_outlined)),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: Icon(Icons.add_shopping_cart)),
                    ],
                  )
                ],
              ),
            ),
            child: Container(
                color: Colors.white,
                padding: EdgeInsetsDirectional.all(24),
                child:
                    Image.asset('${widget.cartModel.medicineModel.imageUrl}'))),
      ),
    );
  }
}