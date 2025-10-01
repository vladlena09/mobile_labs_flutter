import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';

class SlotChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const SlotChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => onTap?.call(),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }
}
