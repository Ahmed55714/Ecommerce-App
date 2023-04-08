// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg/cubit/Dio_helper.dart';
import 'package:gg/cubit/cache_helper.dart';
import 'package:gg/cubit/cubit.dart';

import 'package:gg/screens/Login_screen.dart';
import 'package:gg/screens/shop/catigories_screen.dart';
import 'package:gg/screens/shop/shopLayout_screen.dart';

import 'constants/bloc_observer.dart';
import 'screens/Register_screen.dart';

import 'screens/on_boarding/on_boarding_screen.dart';
import 'screens/shop/search.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Helper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  String? token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayoutScreen();
    } else {
      widget = Login();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavourites()
            ..getUserData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/Login': (context) => Login(),
          '/Register': (context) => const Register(),
          '/Home': (context) => const ShopLayoutScreen(),
          'onBording': (context) => OnBoardingScreen(),
          '/search': (context) => const SearchScreen(),
          '/catigories': (context) => const CatigoriesScreen(),
          '/search': (context) => const SearchScreen(),
        },
        home: startWidget,

        //showHome ? HomeScreen() : OnBoardingScreen()
      ),
    );
  }
}
