// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg/cubit/cubit.dart';
import 'package:gg/cubit/status.dart';
import 'package:gg/screens/signout.dart';
import 'package:gg/widgets/custom_loder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/customBotton.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessGetUserDataState) {
          // print(state.loginModel.data!.name);
          // print(state.loginModel.data!.email);
          // print(state.loginModel.data!.phone);
          // nameController.text = state.loginModel.data!.name!;
          // emailController.text = state.loginModel.data!.email!;
          // phoneController.text = state.loginModel.data!.phone!;
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return SafeArea(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      const LinearProgressIndicator(
                        color: Colors.black,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Settings',
                      style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
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
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      autofocus: false,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          height: 1.26,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      autofocus: false,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          height: 1.26,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      autofocus: false,
                    ),
                    const SizedBox(height: 20),
                    CustomBotton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: "Update",
                    ),
                    const SizedBox(height: 20),
                    CustomBotton(
                      onPressed: () {
                        signOut(context);
                      },
                      text: "Logout",
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: Loder()),
          ),
        );
      },
    );
  }
}
