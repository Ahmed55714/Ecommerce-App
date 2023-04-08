// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/customBotton.dart';

class gg extends StatelessWidget {
  const gg({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 77, 231, 157),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            width: 270,
            height: 60,
            child: Center(
              child: Text(
                'Please Login to Use it',
                style: GoogleFonts.outfit(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    height: 1.26,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 70),
        Center(
          child: CustomBotton(
            text: 'Go to Login or Sign Up',
            onPressed: () {
              Navigator.pushNamed(context, '/Login');
            },
          ),
        ),
      ],
    );
  }
}
