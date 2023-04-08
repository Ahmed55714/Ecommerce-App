import 'package:flutter/material.dart';

import '../cubit/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      Navigator.pushNamed(context, '/Login');
    }
  });
}

String token = '';
