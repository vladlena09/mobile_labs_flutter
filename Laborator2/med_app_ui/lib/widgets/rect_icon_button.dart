import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';

class RectIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const RectIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kRadius12),
      child: Ink(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kRadius12),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.subtext),
      ),
    );
  }
}
