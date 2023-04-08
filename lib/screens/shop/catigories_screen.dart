import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gg/cubit/cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/status.dart';
import '../../model/Categories.dart';

class CatigoriesScreen extends StatelessWidget {
  const CatigoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, index) {},
      builder: (context, index) {
        return SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index) => buildItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data.length,
          ),
        );
      },
    );
  }

  Widget buildItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 95,
              width: 95,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(model.image),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(model.name,
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      height: 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  )),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      );
}
