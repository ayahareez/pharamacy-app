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
  const LoginPage({super.key});

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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Pharmacy',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/undraw_medical_care_movn.svg',
                          width: 200.0,
                          height: 200.0,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
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
                          labelStyle: const TextStyle(
                            color: Color(0xff212529),
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(
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
                          labelStyle: const TextStyle(
                            color: Color(0xff212529),
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(
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
                          style: ElevatedButton.styleFrom(
                            //e8D0aa
                            //ffe8d6
                            backgroundColor: const Color(0xfff5e0c0),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text(
                            'login',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'CrimsonText-Regular'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(GuestSignIn());
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xfff5e0c0)),
                          child: const Text('Login as guest',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'CrimsonText-Regular')),
                        ),
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
                            ),
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
                                    color: Color(0xff9b6f35),
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ControllerPage()));
          }
          if (state is UserErrorState) {
            showToast("An error occurred: ${state.error}");
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