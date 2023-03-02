import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    required this.icon,
    required this.label,
    this.onPressed,
    required this.isSelected,
    super.key,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 0),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: TextButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: 16),
            label: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: isSelected
                    ? const Color.fromARGB(41, 255, 255, 255)
                    : Colors.transparent),
          ),
        ),
      ],
    );
  }
}
