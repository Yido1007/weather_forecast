import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final TextTheme textTheme;

  const InfoItem({
    super.key,
    required this.textTheme,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 4),
        Text('$label: $value', style: textTheme.bodyMedium),
      ],
    );
  }
}
