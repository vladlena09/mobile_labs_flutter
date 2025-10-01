import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';

class SpecialistCard extends StatelessWidget {
  final String asset;
  final String title;
  final bool fav;
  final VoidCallback? onTap;

  const SpecialistCard({
    super.key,
    required this.asset,
    required this.title,
    this.fav = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kRadius22),
      child: Ink(
        width: 260,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(kRadius22),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(blurRadius: 10, offset: Offset(0, 2), color: Color(0x11000000)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(kRadius22),
                topRight: Radius.circular(kRadius22),
              ),
              child: Stack(
                children: [
                  Image.asset(asset, width: 260, height: 172, fit: BoxFit.cover),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Icon(
                        fav ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: fav ? Colors.redAccent : AppColors.subtext,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
