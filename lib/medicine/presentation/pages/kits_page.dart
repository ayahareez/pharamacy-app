import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/presentation/pages/your_cart_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/product_grid_tile.dart';

import '../../../user/data/models/user_model.dart';
import '../../../user/presentation/bloc/user_data/user_bloc.dart';
import '../bloc/medicine_bloc/product_bloc.dart';

class KitsPage extends StatefulWidget {
  const KitsPage({super.key});

  @override
  State<KitsPage> createState() => _KitsPageState();
}

class _KitsPageState extends State<KitsPage> {
  late String name;
  late String userId = ''; // Initialize with
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        print(state);
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductLoaded) {
          return Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                title: const Text(
                  'M\'s Remedies',
                  style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YourCartPage()));
                        },
                      ),
                      const CircleAvatar(
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
                  const SizedBox(width: 15),
                ],
              ),
              drawer: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  print(state);
                  if (state is UserLoadedState) {
                    print(state.usersModel.toString());
                    name = state.usersModel.name;

                    if (name.isNotEmpty) {
                      print(name);
                    } else {
                      print('No matching element found');
                    }
                    return Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          DrawerHeader(
                            margin:
                                const EdgeInsetsDirectional.only(bottom: 16),
                            decoration: const BoxDecoration(
                              color: Color(0xffe4d4c5),
                            ),
                            child: Container(
                              height: 50,
                              alignment: AlignmentDirectional.center,
                              child: Text('${state.usersModel.name}',
                                  style: const TextStyle(
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
                                    const Icon(Icons.history_toggle_off),
                                    TextButton(
                                      onPressed: () {
                                        // Handle the first button tap
                                        Navigator.pop(
                                            context); // Close the drawer if needed
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => FirstPage()),
                                        // );
                                      },
                                      child: const Text('Ongoing',
                                          style: TextStyle(
                                              fontFamily: 'CrimsonText-Regular',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Icon(Icons.history),
                                    TextButton(
                                      onPressed: () {
                                        // Handle the second button tap
                                        Navigator.pop(
                                            context); // Close the drawer if needed
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => SecondPage()),
                                        // );
                                      },
                                      child: const Text('History',
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
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              body: Container(
                padding: const EdgeInsetsDirectional.all(8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                  ),
                  itemBuilder: (_, i) =>
                      //
                      ProductGridTile(
                    // cartModel: CartModel(
                    //     medicineModel: state.medicineModels[i],
                    //     id: '',
                    //     qty: 0,
                    //     userId: ''),
                    //
                    medicineModel: state.products[i],
                  ),
                  itemCount: state.products.length,
                ),
              ));
        }
        return const SizedBox();
      },
    );
  }
}