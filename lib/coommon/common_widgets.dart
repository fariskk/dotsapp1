import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text myText(
    {required String text,
    required double size,
    Color? color,
    FontWeight? fontWeight}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.openSans(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

Widget mySpacer({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
