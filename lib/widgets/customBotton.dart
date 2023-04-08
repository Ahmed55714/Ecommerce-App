// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBotton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomBotton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: const Size(20 * 17, 50),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          textStyle: const TextStyle(
            fontSize: 18,
            height: 1.26,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
