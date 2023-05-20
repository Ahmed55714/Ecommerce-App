// ignore_for_file: file_names, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable
//hello
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gg/cubit/cache_helper.dart';
import 'package:gg/cubit/cubit.dart';
import 'package:gg/cubit/status.dart';
import 'package:gg/screens/signout.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom _toast.dart';
import '../widgets/customBotton.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              //print(state.loginModel.message);
              // print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                //u p d a t e  t o  n e w  t o k e n
                token = state.loginModel.data!.token!;
                Navigator.pushNamed(context, '/Home');
              });
            } else {
              //print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'onBording');
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, right: 89, left: 0, bottom: 0),
                              child: Text(
                                'Lets Sign you in',
                                style: GoogleFonts.outfit(
                                  textStyle: const TextStyle(
                                    fontSize: 39,
                                    height: 2,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, right: 77, left: 0, bottom: 0),
                              child: Text(
                                'Welcome Back Pro,\nYou have been missed',
                                style: GoogleFonts.outfit(
                                  textStyle: const TextStyle(
                                    fontSize: 28,
                                    height: 1.26,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 40, right: 0, left: 0, bottom: 10),
                              padding: const EdgeInsets.only(
                                  top: 14, right: 15, left: 14, bottom: 13),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email ,phone & username',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    height: 1.26,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Invalid email!';
                                  }
                                  return null;
                                },
                                autofocus: false,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, right: 0, left: 0, bottom: 0),
                              padding: const EdgeInsets.only(
                                  top: 0, right: 15, left: 14, bottom: 0),
                              child: TextFormField(
                                obscureText: _obscureText,
                                controller: passwordController,
                                onSaved: (value) {
                                  if (_formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  labelStyle: const TextStyle(
                                    fontSize: 16,
                                    height: 1.26,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                autofocus: false,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 5) {
                                    return 'Password is too short!';
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, right: 0, left: 189, bottom: 0),
                              child: TextButton(
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.outfit(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      height: 1.26,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => CustomBotton(
                                text: 'Sign in',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              ),
                              fallback: (context) =>
                                  const CircularProgressIndicator(
                                      color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Divider(
                                    height: 4,
                                    color: Colors.grey,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      'or',
                                      style: GoogleFonts.outfit(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            height: 1.26,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      height: 4,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(top: 0, left: 50),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white24,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/search.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Google',
                                        style: GoogleFonts.outfit(
                                          textStyle: const TextStyle(
                                            fontSize: 19,
                                            height: 1.26,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: TextButton(
                                          onPressed: () async {
                                            // final prefs =
                                            //     await SharedPreferences
                                            //         .getInstance();
                                            // prefs.setBool('showHome', true);

                                            Navigator.pushNamed(
                                                context, '/Home');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(90, 50),
                                          ),
                                          child: const Text(
                                            "Go as Guest",
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have account?'),
                                  TextButton(
                                    child: Text(
                                      'Register Now',
                                      style: GoogleFonts.outfit(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          height: 1.26,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/Register');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
