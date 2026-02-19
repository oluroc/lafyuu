import 'package:flutter/material.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onpressed;
  final Widget? child;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;


  const MyButton({
    super.key,
    required this.child,
    required this.onpressed,
    this.textColor,
    this.backgroundColor, this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: borderColor ?? kprimaryBlue),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
      ),
      onPressed: onpressed,
      child: child,
    );
  }
}
