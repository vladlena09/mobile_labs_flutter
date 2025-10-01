import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    final filled = rating.floor();
    final hasHalf = (rating - filled) >= 0.5;

    return Row(
      children: List.generate(5, (i) {
        IconData icon;
        if (i < filled) {
          icon = Icons.star_rounded;
        } else if (i == filled && hasHalf) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_border_rounded;
        }
        return Icon(icon, size: size, color: AppColors.primary);
      }),
    );
  }
}
