import 'package:flutter/material.dart';
import 'package:med_app_ui/widgets/quick_action_card.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Book Appointment', Icons.calendar_month,   'assets/images/quick_book.jpg'),
      ('Instant Video Consult', Icons.videocam_outlined, 'assets/images/quick_video.jpg'),
      ('Medicines',           Icons.medication_outlined, 'assets/images/quick_meds.jpg'),
      ('Lab Tests',           Icons.biotech_outlined,    'assets/images/quick_lab.jpg'),
      ('Emergency',           Icons.emergency_outlined,  'assets/images/quick_emergency.jpg'),
    ];

    return Column(
      children: [
        // rândul 1 – 2 carduri
        Row(
          children: [
            Expanded(child: _tile(items[0])),
            const SizedBox(width: 16),
            Expanded(child: _tile(items[1])),
          ],
        ),
        const SizedBox(height: 16),
        // rândul 2 – 3 carduri
        Row(
          children: [
            Expanded(child: _tile(items[2])),
            const SizedBox(width: 16),
            Expanded(child: _tile(items[3])),
            const SizedBox(width: 16),
            Expanded(child: _tile(items[4])),
          ],
        ),
      ],
    );
  }

  Widget _tile((String, IconData, String) it) {
    return QuickActionCard(
      icon: it.$2,
      title: it.$1,
      imageUrl: it.$3,
    );
  }
}
