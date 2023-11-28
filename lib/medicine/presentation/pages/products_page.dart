import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';
import 'package:pharmacy/medicine/presentation/pages/search.dart';
import 'package:pharmacy/medicine/presentation/pages/your_cart_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/medicine_grid_tile.dart';

import '../../../user/data/models/user_model.dart';
import '../../../user/presentation/bloc/user_data/user_bloc.dart';
import '../../data/data_source/medicine_local_ds.dart';
import '../bloc/medicine_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Set name;
  late String userId = ''; // Initialize with an empty string
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    _initializeData();
    context.read<MedicineBloc>().add(GetMedicines());
    searchController = TextEditingController();
  }

  Future<void> _initializeData() async {
    context.read<UserBloc>().add(GetUserEvent());
    User? user = FirebaseAuth.instance.currentUser;
    //print(user);
    if (user != null) {
      userId = user.uid;
    }
    print(userId);

    setState(() {});
    print('aya');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineBloc, MedicineState>(
      builder: (context, state) {
        if (state is MedicineLoading) {
          return CircularProgressIndicator();
        }
        if (state is MedicineLoaded) {
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
                  'M\'s Remedies',
                  style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 32,
                    ),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate:
                            MedicineSearchDelegate(medicines: state.medicines),
                      );
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YourCartPage()));
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
              drawer: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  print(state);
                  if (state is UserLoadedState) {
                    print(state.usersModel.toString());
                    name = state.usersModel
                        .where((element) => element.id == userId)
                        .toList()
                        .toSet();
                    name = state.usersModel
                        .where((element) => element.id == userId)
                        .toSet();

                    if (name.isNotEmpty) {
                      print(name.first);
                    } else {
                      print('No matching element found');
                    }
                    return Drawer(
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
                              child: Text(
                                  '${state.usersModel.isNotEmpty ? state.usersModel.firstWhere((element) => element.id == userId, orElse: () => UserModel(name: '', id: ''))?.name : ''}',
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
                                        Navigator.pop(
                                            context); // Close the drawer if needed
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
                                        Navigator.pop(
                                            context); // Close the drawer if needed
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
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              body: Container(
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
              ));
        }
        return SizedBox();
      },
    );
  }
}