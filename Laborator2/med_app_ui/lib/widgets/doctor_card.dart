import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';
import 'package:med_app_ui/models.dart';
import 'package:med_app_ui/widgets/rating_stars.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap;

  const DoctorCard({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final initials = doctor.name
        .split(' ')
        .where((p) => p.isNotEmpty)
        .map((p) => p[0])
        .take(2)
        .join();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(kRadius16),
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(kRadius16),
          border: Border.all(color: AppColors.border),
        ),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  // Dacă imaginea se încarcă, e folosită; altfel rămâne background+inițiale
                  foregroundImage: NetworkImage(doctor.avatarUrl),
                  backgroundColor: Colors.teal.shade100,
                  child: Text(
                    initials,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16)),
                      Text(doctor.specialty,
                          style: const TextStyle(color: AppColors.subtext)),
                    ],
                  ),
                ),
              ],
            ),
            kGap12,
            RatingStars(rating: doctor.rating),
            kGap8,
            Row(
              children: [
                _stat('Years', '${doctor.yearsOfWork}'),
                const SizedBox(width: 12),
                _stat('Patients', '${doctor.patients}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.pill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: AppColors.subtext)),
        ],
      ),
    );
  }
}
