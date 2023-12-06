import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/data/models/product_model.dart';

class ProductInfoPage extends StatelessWidget {
  final ProductModel productModel;

  const ProductInfoPage({super.key, required this.productModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${productModel.productName}',
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                '${productModel.imageUrl}',
                fit: BoxFit.cover,
                width: 250,
              ),
              const SizedBox(
                height: 16,
              ),
              Text('${productModel.description}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Price :  ${productModel.price}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}