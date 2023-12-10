import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/presentation/pages/contoller_page.dart';
import 'package:pharmacy/medicine/presentation/pages/daily_essential.dart';
import 'package:pharmacy/medicine/presentation/pages/history_page.dart';
import 'package:pharmacy/medicine/presentation/pages/ongoing_page.dart';
import 'package:pharmacy/medicine/presentation/pages/personal_care.dart';
import 'package:pharmacy/medicine/presentation/pages/products_page.dart';
import 'package:pharmacy/medicine/presentation/pages/your_cart_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/product_grid_tile.dart';
import 'package:pharmacy/user/presentation/pages/login_page.dart';
import '../../../user/data/models/user_model.dart';
import '../../../user/presentation/bloc/auth/auth_bloc.dart';
import '../../../user/presentation/bloc/user_data/user_bloc.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/product_model.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/medicine_bloc/product_bloc.dart';
import '../widgets/custom_keyboard.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  late String name;
  late String userId = ''; // Initialize with an empty string
  bool cartFetched = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!cartFetched) {
      _initializeData();
      context.read<ProductBloc>().add(GetProducts());
      cartFetched = true;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   context.read<ProductBloc>().add(GetProducts());
  //   //context.read<CartBloc>().add(GetCart());
  // }

  Future<void> _initializeData() async {
    context.read<UserBloc>().add(GetUserEvent());
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    // print(userId);
    // print('aya');
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
          List<ProductModel> filteredProducts = state.products
              .where((product) => product.productName
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList();
          List<ProductModel> displayProducts = _searchController.text.isEmpty
              ? state.products
              : filteredProducts;
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 32,
                    ),
                    onPressed: () {
                      _showSearchBottomSheet(context);
                    },
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
                                  builder: (context) => const YourCartPage()));
                        },
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartLoaded) {
                              int theTotal = total(state.cartModels);
                              return Text(
                                theTotal == 0 ? '' : "${theTotal}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }
                            return const Text(
                              "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      )
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
                              child: Column(
                                children: [
                                  Text(state.usersModel.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26)),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.popUntil(
                                            context,
                                            (_) => false,
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()));
                                          context
                                              .read<AuthBloc>()
                                              .add(SignOut());
                                        },
                                        child: const Text('LogOut',
                                            style: TextStyle(
                                                fontFamily:
                                                    'CrimsonText-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                      const Icon(Icons.logout),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.home),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ControllerPage()),
                                        );
                                      },
                                      child: const Text('Home',
                                          style: TextStyle(
                                              fontFamily: 'CrimsonText-Regular',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.history_toggle_off),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const OngoingPage()),
                                        );
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
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.history),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HistoryPage()),
                                        );
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
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.health_and_safety),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HealthPage()),
                                        );
                                      },
                                      child: const Text('Health',
                                          style: TextStyle(
                                              fontFamily: 'CrimsonText-Regular',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.local_pharmacy),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DailyEssential()),
                                        );
                                      },
                                      child: const Text('Daily Essentials',
                                          style: TextStyle(
                                              fontFamily: 'CrimsonText-Regular',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.self_improvement),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PersonalCare()),
                                        );
                                      },
                                      child: const Text('Personal Care',
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
                    medicineModel: displayProducts
                        .where((element) => element.category == 'A')
                        .toList()[i],
                  ),
                  itemCount: displayProducts
                      .where((element) => element.category == 'A')
                      .toList()
                      .length,
                ),
              ));
        }
        return const SizedBox();
      },
    );
  }

  int total(List<CartModel> cartModels) {
    int total = 0;
    for (int i = 0; i < cartModels.length; i++) {
      total += cartModels[i].qty;
    }
    return total;
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xffEBE7DC),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                ),
                controller: _searchController,
                onChanged: (value) {
                  _filterProducts(value);
                },
              ),
              const SizedBox(height: 16),
              CustomKeyboard(
                controller: _searchController,
                onKeyPressed: (char) {
                  if (char == 'ALL') {
                    _searchController.clear();
                    _filterProducts('');
                  } else {
                    setState(() {
                      _searchController.text += char;
                      _searchController.selection =
                          TextSelection.fromPosition(TextPosition(
                        offset: _searchController.text.length,
                      ));
                      _filterProducts(_searchController.text);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      // Show all products when query is empty
      context.read<ProductBloc>().add(GetProducts());
    } else {
      context.read<ProductBloc>().add(SearchProducts(query: query));
    }
  }
}