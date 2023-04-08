import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/status.dart';
import '../../widgets/custom _toast.dart';
import '../../widgets/custom_loder.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, index) {},
      builder: (context, index) {
        return SafeArea(
          child: ConditionalBuilder(
            condition: index is! ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildList(
                  ShopCubit.get(context)
                      .favouritesModel!
                      .data!
                      .data![index]
                      .product,
                  context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  ShopCubit.get(context).favouritesModel!.data!.data!.length,
            ),
            fallback: (context) => const Center(child: Loder()),
          ),
        );
      },
    );
  }
}
