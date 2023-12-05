import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/medicine/presentation/pages/contoller_page.dart';
import 'package:pharmacy/user/presentation/pages/login_page.dart';

import '../../data/models/auth_model.dart';
import '../../data/models/user_model.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/user_data/user_bloc.dart';

class SignUpPage extends StatelessWidget {
  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: Lottie.asset(
                        'assets/animation/Animation - encaps.json'),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'CrimsonText-Regular'),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: name,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          fontFamily: 'CrimsonText-Regular',
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Color(0xffd4a276)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must be entered';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontFamily: 'CrimsonText-Regular',
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Color(0xffd4a276)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must be entered';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: password,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontFamily: 'CrimsonText-Regular',
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Color(0xffd4a276)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must be entered';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          AuthModel authModel = AuthModel(
                            password: password.text,
                            email: email.text,
                          );
                          UserModel userModel =
                              UserModel(name: name.text, userId: '');
                          context.read<AuthBloc>().add(SignUp(
                              authModel: authModel, userModel: userModel));

                          context
                              .read<UserBloc>()
                              .add(SetUserEvent(userModel: userModel));

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ControllerPage()));
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CrimsonText-Regular',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff5e0c0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}