import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/medicine/data/data_source/medicine_local_ds.dart';
import 'package:pharmacy/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pharmacy/medicine/presentation/pages/checkout_page.dart';
import 'package:pharmacy/medicine/presentation/pages/contoller_page.dart';
import 'package:pharmacy/medicine/presentation/pages/history_page.dart';
import 'package:pharmacy/medicine/presentation/pages/kits_page.dart';
import 'package:pharmacy/medicine/presentation/pages/ongoing_page.dart';
import 'package:pharmacy/medicine/presentation/pages/products_page.dart';
import 'package:pharmacy/medicine/presentation/pages/start_page.dart';
import 'package:pharmacy/medicine/presentation/pages/your_cart_page.dart';
import 'package:pharmacy/medicine/presentation/widgets/medicine_grid_tile.dart';
import 'package:pharmacy/medicine/presentation/widgets/your_cart_grid_tile.dart';
import 'package:pharmacy/user/data/data_source/auth_remote_ds.dart';
import 'package:pharmacy/user/data/data_source/user_remote_ds.dart';
import 'package:pharmacy/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:pharmacy/user/presentation/bloc/user_data/user_bloc.dart';
import 'package:pharmacy/user/presentation/pages/login_page.dart';
import 'package:pharmacy/user/presentation/pages/signup_page.dart';

import 'core/remote_db_handler.dart';
import 'medicine/data/data_source/medicine_remote_ds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await AuthinticationRemoteDsImpl().signOut();
  //await MedicineRemoteDsImpl(dbHelper: RemoteDbHelperImpl()).setMedicines();
  //await MedicineRemoteDsImpl(dbHelper: RemoteDbHelperImpl()).setMedicine(medicines[0]);
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthBloc(AuthinticationRemoteDsImpl())),
    BlocProvider(
        create: (_) =>
            UserBloc(UserDBModelImp(dbHelper: RemoteDbHelperImpl()))),
    BlocProvider(
        create: (_) => MedicineBloc(
            medicineRemoteDs:
                MedicineRemoteDsImpl(dbHelper: RemoteDbHelperImpl()))),
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
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          displayLarge: TextStyle(
            color: Colors.blue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffE8D9C4),
            foregroundColor: Color(0xff212529)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, background: const Color(0xffEBE7DC)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}