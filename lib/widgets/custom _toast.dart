// ignore_for_file: file_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/cubit.dart';

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildList(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: NetworkImage(model.image!),
                    width: 120,
                    height: 120,
                  ),
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    height: 120,
                    width: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text('DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        )),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          width: 9.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    height: 38,
                    width: 38,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                      color: Colors.black,
                    ),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon:
                            //(ShopCubit.get(context).favorites[model.id]!)
                            (ShopCubit.get(context).favorites[model.id]!)
                                ? const Icon(
                                    Icons.favorite,
                                    size: 22,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 22,
                                    color: Colors.white,
                                  )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
