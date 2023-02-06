import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.func,
    Key? key,
    this.foregroundColor,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
  }) : super(key: key);

  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final String text;
  final double fontSize;
  final double width;
  final double height;
  final double? elevation;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          Color.fromRGBO(255, 255, 255, 0.2),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          foregroundColor ?? Colors.white,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? primaryColor
        ),
        elevation: MaterialStateProperty.all<double>(elevation ?? 2),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(fontSize: fontSize, shadows: const <Shadow>[
            Shadow(
              offset: Offset(-1, -1),
              blurRadius: 1,
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ]),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(width, height),
        ),
      ),
      onPressed: func,
      child: Text(text),
    );
  }
}
