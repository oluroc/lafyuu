import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  const ButtonContainer({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: child,
      ),
    );
  }
}
