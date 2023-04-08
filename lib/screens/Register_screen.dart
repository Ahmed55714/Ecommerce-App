// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg/cubit/status.dart';
import 'package:gg/screens/signout.dart';
import 'package:gg/widgets/custom_loder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/cache_helper.dart';
import '../cubit/cubit.dart';
import '../widgets/custom _toast.dart';
import '../widgets/customBotton.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool _obscureText = true;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              //print(state.loginModel.message);
              //print(state.loginModel.data!.token);

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
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, right: 115, left: 0, bottom: 0),
                          child: Text(
                            'Lets Register',
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
                              top: 5, right: 77, left: 10, bottom: 0),
                          child: Text(
                            'Hello Pro, You have a greatful journey',
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
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, right: 0, left: 0, bottom: 0),
                          padding: const EdgeInsets.only(
                              top: 0, right: 15, left: 14, bottom: 0),
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              labelStyle: TextStyle(
                                fontSize: 16,
                                height: 1.26,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Name!';
                              }
                              return null;
                            },
                            autofocus: false,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, right: 0, left: 0, bottom: 10),
                          padding: const EdgeInsets.only(
                              top: 0, right: 15, left: 14, bottom: 13),
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
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, right: 0, left: 0, bottom: 0),
                          padding: const EdgeInsets.only(
                              top: 0, right: 15, left: 14, bottom: 0),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                fontSize: 16,
                                height: 1.26,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid phone!';
                              }
                              return null;
                            },
                            autofocus: false,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => CustomBotton(
                              text: 'SignUp',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          fallback: (context) => const Center(
                            child: Loder(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have account?'),
                              TextButton(
                                child: Text(
                                  'Login',
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
                                  Navigator.pushNamed(context, '/Login');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
