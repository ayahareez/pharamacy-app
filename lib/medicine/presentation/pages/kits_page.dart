import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/presentation/pages/your_cart_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/medicine_grid_tile.dart';

import '../../data/models/cart_model.dart';
import '../bloc/medicine_bloc.dart';

class KitsPage extends StatefulWidget {
  const KitsPage({super.key});

  @override
  State<KitsPage> createState() => _KitsPageState();
}

class _KitsPageState extends State<KitsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MedicineBloc>().add(GetMedicines());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          'Kits',
          style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 32,
            ),
            onPressed: () {
              // Handle search action
            },
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => YourCartPage()));
                },
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 8,
                child: Text(
                  "7",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsetsDirectional.only(bottom: 16),
              decoration: BoxDecoration(
                color: Color(0xffe4d4c5),
              ),
              child: Container(
                height: 50,
                alignment: AlignmentDirectional.center,
                child: Text('Aya Taha',
                    style: TextStyle(
                        fontFamily: 'CrimsonText-Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 26)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history_toggle_off),
                      TextButton(
                        onPressed: () {
                          // Handle the first button tap
                          Navigator.pop(context); // Close the drawer if needed
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => FirstPage()),
                          // );
                        },
                        child: Text('Ongoing',
                            style: TextStyle(
                                fontFamily: 'CrimsonText-Regular',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.history),
                      TextButton(
                        onPressed: () {
                          // Handle the second button tap
                          Navigator.pop(context); // Close the drawer if needed
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SecondPage()),
                          // );
                        },
                        child: Text('History',
                            style: TextStyle(
                                fontFamily: 'CrimsonText-Regular',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Add more ListTile widgets for additional menu items
          ],
        ),
      ),
      body: BlocBuilder<MedicineBloc, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading) {
            return CircularProgressIndicator();
          }
          if (state is MedicineLoaded) {
            return Container(
              padding: EdgeInsetsDirectional.all(8),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                ),
                itemBuilder: (_, i) => MedicineGridTile(
                  cartModel: CartModel(
                      medicineModel: state.medicines[i], id: '', qty: 0),
                ),
                itemCount: state.medicines.length,
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}