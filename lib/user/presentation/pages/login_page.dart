import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/medicine/presentation/pages/contoller_page.dart';
import 'package:pharmacy/user/presentation/pages/signup_page.dart';
import '../../data/models/auth_model.dart';
import '../bloc/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckIfAuth());
    super.initState();
  }

  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          print(state);
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserErrorState) {
            showToast("An error occurred: ${state.error}");
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Pharmacy',
                          style: TextStyle(
                              fontSize: 24, fontFamily: 'CrimsonText-Regular'),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_medical_care_movn.svg', // Replace with the path to your SVG file
                          width: 200.0, // Adjust the width as needed
                          height: 200.0, // Adjust the height as needed
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Color(0xff212529),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CrimsonText-Regular'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xffd4a276),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email must  be entered';
                          } else if (value.length < 5 ||
                              value.startsWith('@') ||
                              !value.contains("@") ||
                              !value.endsWith('.com')) {
                            return 'please enter the email correct';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: password,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Color(0xff212529),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CrimsonText-Regular'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xffe6ccb2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password must be entered';
                          }
                          if (value.length < 8) {
                            return 'password length can not be less than 8';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthModel userModel = AuthModel(
                                  password: password.text, email: email.text);
                              context
                                  .read<AuthBloc>()
                                  .add(SignIn(userModel: userModel));
                            }
                          },
                          child: Text(
                            'login',
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'CrimsonText-Regular'),
                          ),
                          style: ElevatedButton.styleFrom(
                            //e8D0aa
                            //ffe8d6
                            backgroundColor: const Color(0xfff5e0c0),
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ControllerPage()));
                        },
                        child: const Text('login as geust',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'CrimsonText-Regular')),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff5e0c0)),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account ? ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: 'CrimsonText-Regular'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignUpPage()));
                            },
                            child: const Text('Register now',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffAB9D88),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'CrimsonText-Regular')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state is UserAuthorizedState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ControllerPage()));
          }
        },
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}