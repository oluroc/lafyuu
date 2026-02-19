import 'package:flutter/cupertino.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontize;
  final String? fontFamily;
  final Function()? onPressed;
  final TextAlign? textAlign;

  const MyTextButton({
    this.onPressed,
    required this.text,
    super.key,
    this.color,
    this.fontize,
    this.fontFamily,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: fontize,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
