import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/presentation/pages/checkout_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/your_cart_grid_tile.dart';

class YourCartPage extends StatefulWidget {
  @override
  State<YourCartPage> createState() => _YourCartPageState();
}

class _YourCartPageState extends State<YourCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(8),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ListView.separated(
              itemBuilder: (_, i) => YourCartGridTile(),
              itemCount: 3,
              separatorBuilder: (_, i) => SizedBox(
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
                        'Total',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CrimsonText-Regular'),
                      ),
                      Spacer(),
                      Text(
                        '490 EGP',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CrimsonText-Regular'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutPage()));
                      },
                      child: Text(
                        'PROCEED TO CHECKOUT',
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'CrimsonText-Regular'),
                      ),
                      style: ElevatedButton.styleFrom(
                        //e8D0aa
                        //ffe8d6
                        backgroundColor: const Color(0xfff5e0c0),
                        foregroundColor: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}