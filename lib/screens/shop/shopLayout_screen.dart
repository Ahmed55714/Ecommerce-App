// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg/cubit/status.dart';
import 'package:gg/screens/shop/settings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../cubit/cubit.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5,
              ),
              child: GNav(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: const Color.fromARGB(255, 48, 48, 48),
                  gap: 8,
                  onTabChange: (index) {
                    cubit.ChangeBottom(index);
                  },
                  selectedIndex: cubit.currentIndex,
                  padding: const EdgeInsets.all(16),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'home',
                    ),
                    GButton(
                      icon: Icons.category,
                      text: 'category',
                    ),
                    GButton(
                      icon: Icons.favorite_border,
                      text: 'favorite',
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: 'settings',
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
