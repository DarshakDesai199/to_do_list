import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final int? maxLine;
  final double? fontSize, height, letterSpacing, wordSpacing;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  const CommonText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.overflow,
    this.height,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily = 'Montserrat',
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        height: height,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        fontFamily: fontFamily,
      ),
    );
  }
}
