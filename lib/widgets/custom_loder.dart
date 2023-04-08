import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loder extends StatelessWidget {
  const Loder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCircle(
        size: 60,
        color: Colors.black,
        // itemBuilder: (_, int index) {
        //   return DecoratedBox(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: index.isEven ? Color(0xFF7a9ee6),),);
        // },
      ),
    );
  }
}
