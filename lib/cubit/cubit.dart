// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg/cubit/Dio_helper.dart';
import 'package:gg/cubit/status.dart';
import 'package:gg/cubit/end_points.dart';
import 'package:gg/model/Categories.dart';
import 'package:gg/model/home.dart';
import 'package:gg/model/search.dart';
import 'package:gg/model/shop.dart';
import 'package:gg/screens/shop/catigories_screen.dart';
import 'package:gg/screens/shop/favourite_screen.dart';
import 'package:gg/screens/shop/settings.dart';

import '../model/favoriteModel.dart';
import '../model/favorites.dart';
import '../screens/shop/gg.dart';
import '../screens/shop/home.dart';
import '../screens/signout.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    Helper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      //print(error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    Helper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      // print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List bottomScreens = [
    const Shop(),
    const CatigoriesScreen(),
    if (token.isEmpty) const gg() else const FavouriteScreen(),
    if (token.isEmpty) const gg() else SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDateState());

    Helper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      //print(homeModel!.data!.banners[0].image);
      //print(homeModel!.status);

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      //print(favorites.toString());

      emit(ShopSuccessHomeDateState());
    }).catchError((error) {
      //print(error.toString());

      emit(ShopErrorHomeDateState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    Helper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      //print(error.toString());

      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopErrorChangeFavoritesState());

    Helper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
      //'kL4y8ZxQZ6WhSWYLHrUF2I1kTuThBUfCbsNQ21ukX3FXyLG7xZz6ALUQixUMhcKwZKpKQp',
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);
      //if token do not do enything
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavourites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavouritesModel? favouritesModel;

  void getFavourites() {
    emit(ShopLoadingGetFavoritesState());
    Helper.getData(
      url: FAVORITES,
      token: token,
      //'kL4y8ZxQZ6WhSWYLHrUF2I1kTuThBUfCbsNQ21ukX3FXyLG7xZz6ALUQixUMhcKwZKpKQp',
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      //print(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      //print(error.toString());

      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    Helper.getData(
      url: PROFILE,
      token: token,
      // 'kL4y8ZxQZ6WhSWYLHrUF2I1kTuThBUfCbsNQ21ukX3FXyLG7xZz6ALUQixUMhcKwZKpKQp',
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      //print(error.toString());

      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    Helper.putData(
      url: UPDATE_PROFILE,
      token: token,
      //'kL4y8ZxQZ6WhSWYLHrUF2I1kTuThBUfCbsNQ21ukX3FXyLG7xZz6ALUQixUMhcKwZKpKQp',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      //print(error.toString());

      emit(ShopErrorUpdateUserDataState());
    });
  }
}

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text) {
    Helper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(SearchErrorState());
    });
  }
}
