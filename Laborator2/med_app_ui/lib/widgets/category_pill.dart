import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';

class CategoryPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryPill({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cercul cu icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? AppColors.primary.withOpacity(0.15) // verde deschis
                  : Colors.grey.shade200,               // gri deschis
            ),
            child: Icon(
              icon,
              color: selected ? AppColors.primary : AppColors.subtext,
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          // Textul
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
