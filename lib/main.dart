import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/medicine/data/data_source/cart_remore_ds.dart';
import 'package:pharmacy/medicine/data/data_source/checkout_remote_ds.dart';
import 'package:pharmacy/medicine/data/data_source/product_local_ds.dart';
import 'package:pharmacy/medicine/data/models/cart_model.dart';
import 'package:pharmacy/medicine/data/models/product_model.dart';
import 'package:pharmacy/medicine/presentation/pages/checkout_page.dart';
import 'package:pharmacy/medicine/presentation/pages/contoller_page.dart';
import 'package:pharmacy/medicine/presentation/pages/history_page.dart';
import 'package:pharmacy/medicine/presentation/pages/kits_page.dart';
import 'package:pharmacy/medicine/presentation/pages/ongoing_page.dart';
import 'package:pharmacy/medicine/presentation/pages/products_page.dart';
import 'package:pharmacy/medicine/presentation/pages/start_page.dart';
import 'package:pharmacy/medicine/presentation/pages/your_cart_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/checkout_grid_tile.dart';
import 'package:pharmacy/medicine/presentation/widgets/product_grid_tile.dart';
import 'package:pharmacy/medicine/presentation/widgets/your_cart_grid_tile.dart';
import 'package:pharmacy/user/data/data_source/auth_remote_ds.dart';
import 'package:pharmacy/user/data/data_source/user_remote_ds.dart';
import 'package:pharmacy/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmacy/user/presentation/bloc/user_data/user_bloc.dart';
import 'package:pharmacy/user/presentation/pages/login_page.dart';
import 'package:pharmacy/user/presentation/pages/signup_page.dart';

import 'core/remote_db_handler.dart';
import 'medicine/data/data_source/product_remote_ds.dart';
import 'medicine/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'medicine/presentation/bloc/checkout_bloc/checkout_bloc.dart';
import 'medicine/presentation/bloc/medicine_bloc/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await AuthinticationRemoteDsImpl().signOut();
  //await ProductRemoteDsImpl(dbHelper: RemoteDbHelperImpl()).setMedicines();
  //await MedicineRemoteDsImpl(dbHelper: RemoteDbHelperImpl()).setMedicine(medicines[0]);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (_) => AuthBloc(
            usersDBModel: UsersRemoteDsImp(dbHelper: RemoteDbHelperImpl()),
            authinticationRemoteDs: AuthinticationRemoteDsImpl())),
    BlocProvider(
        create: (_) => UserBloc(
            usersDBModel: UsersRemoteDsImp(dbHelper: RemoteDbHelperImpl()),
            authinticationRemoteDs: AuthinticationRemoteDsImpl())),
    BlocProvider(
      create: (_) => ProductBloc(
          productRemoteDs: ProductRemoteDsImpl(dbHelper: RemoteDbHelperImpl())),
    ),
    BlocProvider(
      create: (_) => CartBloc(
          cartRemoteDs: CartRemoteDsImpl(dbHelper: RemoteDbHelperImpl())),
    ),
    BlocProvider(
      create: (_) => CheckoutBloc(
          checkoutRemoteDs:
              CheckoutRemoteDsImpl(dbHelper: RemoteDbHelperImpl())),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xfff5e0c0),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xffEBE7DC),
          width: 200,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontFamily: 'CrimsonText-Regular',
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: 'CrimsonText-Regular',
          ),
          displayLarge: TextStyle(
            color: Colors.black,
            fontFamily: 'CrimsonText-Regular',
          ),
        ),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: 'CrimsonText-Regular',
              fontSize: 24,
            ),
            backgroundColor: Color(0xffE8D9C4),
            foregroundColor: Color(0xff212529)),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          background: const Color(0xffEBE7DC),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}