import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout',
            style: TextStyle(fontSize: 24, fontFamily: 'CrimsonText-Regular')),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
                top: 32, start: 16, end: 16, bottom: 16),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(color: Colors.transparent),
                  children: [
                    buildTableRow(
                        ['QTY', 'PRODUCT NAME   ', '  PRICE'],
                        TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CrimsonText-Regular')),
                    buildTableRow(
                      ['2', 'Panadole', '  20 EGP'],
                      TextStyle(
                          fontSize: 16, fontFamily: 'CrimsonText-Regular'),
                    ),
                    buildTableRow(
                        ['2', 'Abelmoschus 12C', '  140 EGP'],
                        TextStyle(
                            fontSize: 16, fontFamily: 'CrimsonText-Regular')),
                    buildTableRow(
                        ['3', 'panda', '  140 EGP'],
                        TextStyle(
                            fontSize: 16, fontFamily: 'CrimsonText-Regular')),
                  ],
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Color(0xffE2D2B8),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CrimsonText-Regular',
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        '490 EGP',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CrimsonText-Regular',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // Show the overlay page
                      _showOverlayPage(context);
                    },
                    child: Text(
                      'CONFIRM ORDER',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'CrimsonText-Regular'),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xfff5e0c0),
                      primary: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TableRow buildTableRow(List<String> cells, TextStyle style) {
    return TableRow(
      children: cells
          .map(
            (cell) => buildTableCell(cell, style),
          )
          .toList(),
    );
  }

  TableCell buildTableCell(String text, TextStyle style) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style,
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
          backgroundColor: Color(0xffEBE7DC),
          title: const Text('Delivery details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement your logic for confirming the order
                  // You can access the text form field values here
                  for (int i = 0; i < controllers.length; i++) {
                    print('Field ${i + 1}: ${controllers[i].text}');
                  }
                  Navigator.pop(context); // Close the overlay page
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Color(0xffEBE7DC)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}