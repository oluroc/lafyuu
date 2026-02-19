import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Widget? widget;

  const ProfileRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    required this.onTap,
    this.widget
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.lightBlue),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            if (value != null)
              Text(
                value!,
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(width: 8),
            ?widget,
          ],
        ),
      ),
    );
  }
}
