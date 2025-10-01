import 'package:flutter/material.dart';
import 'package:med_app_ui/models.dart';
import 'package:med_app_ui/theme.dart';
import 'package:med_app_ui/widgets/slot_chip.dart';

class DoctorDetailScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  // Tab index: 0 = Info, 1 = History, 2 = Review (doar UI)
  int _tabIndex = 0;

  // Selecția zilei și a slotului
  String dayKey = 'Tomorrow';
  String? selectedSlot;

  @override
  void initState() {
    super.initState();
    if (!widget.doctor.slotsByDay.containsKey(dayKey)) {
      dayKey = widget.doctor.slotsByDay.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.doctor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardiologist'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.star_border_rounded),
          SizedBox(width: 8),
          Icon(Icons.settings_outlined),
          SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _header(d),
          kGap16,
          _appointmentSection(d),
          kGap16,
          _timingSection(),
          kGap16,
          _locationsSection(d),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton(
          onPressed: (selectedSlot != null) ? () {} : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: AppColors.primary,
          ),
          child: Text(
            selectedSlot == null ? 'Select a slot' : 'Confirm ${selectedSlot!}',
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────── Header (avatar + nume + stats + tab-uri)
  Widget _header(Doctor d) {
    return Card(
      elevation: 0,
      color: AppColors.pill, // ușor verde, ca în mock
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(d.avatarUrl),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Cardiologist',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'MBBS',
                        style: TextStyle(color: AppColors.subtext),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            kGap12,
            Row(
              children: [
                _statTile(
                  icon: Icons.star_rate_rounded,
                  value: d.rating.toStringAsFixed(1),
                  label: 'Rating & Review',
                ),
                _vDivider(),
                _statTile(
                  icon: Icons.badge_outlined,
                  value: '${d.yearsOfWork}',
                  label: 'Years of work',
                ),
                _vDivider(),
                _statTile(
                  icon: Icons.people_alt_outlined,
                  value: '${d.patients}',
                  label: 'No. of patients',
                ),
              ],
            ),
            kGap12,
            Row(
              children: [
                Expanded(child: _tab('Info', 0)),
                const SizedBox(width: 8),
                Expanded(child: _tab('History', 1)),
                const SizedBox(width: 8),
                Expanded(child: _tab('Review', 2)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statTile({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.subtext,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vDivider() {
    return Container(
      width: 12,
      alignment: Alignment.center,
      child: Container(
        width: 1,
        height: 28,
        color: AppColors.border,
      ),
    );
  }

  Widget _tab(String text, int index) {
    final selected = _tabIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _tabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : AppColors.bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.text : AppColors.subtext,
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────── In-Clinic Appointment
  Widget _appointmentSection(Doctor d) {
    const price = '৳1,000';
    final days = d.slotsByDay.keys.toList();

    return Card(
      elevation: 0,
      color: AppColors.pill.withOpacity(.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'In-Clinic Appointment',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_hospital_outlined),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Evercare Hospital Ltd.',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text('Bashundhara, Dhaka',
                            style: TextStyle(color: AppColors.subtext)),
                        SizedBox(height: 2),
                        Text(
                          '20 mins or less wait time',
                          style: TextStyle(
                            color: AppColors.subtext,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            kGap12,
            // Zile
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: days.map((dk) {
                  final isSelected = dk == dayKey;
                  final slots = d.slotsByDay[dk] ?? [];
                  final suffix =
                  slots.isEmpty ? '  (No Slot)' : '  (${slots.length} Slot)';
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        dk + suffix,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      selected: isSelected,
                      onSelected: (_) => setState(() {
                        dayKey = dk;
                        selectedSlot = null;
                      }),
                    ),
                  );
                }).toList(),
              ),
            ),
            kGap12,
            // Sloturi
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: (d.slotsByDay[dayKey] ?? []).map((s) {
                final isSel = s == selectedSlot;
                return SlotChip(
                  label: s,
                  selected: isSel,
                  onTap: () => setState(() => selectedSlot = s),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────── Timing
  Widget _timingSection() {
    final items = [
      ('Monday', '09:00 AM - 05:00 PM'),
      ('Tuesday', 'Closed'),
      ('Wednesday', '09:00 AM - 05:00 PM'),
    ];

    return Card(
      elevation: 0,
      color: AppColors.bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Timing',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            kGap12,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: items
                  .map((e) => _timeCard(day: e.$1, hours: e.$2))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeCard({required String day, required String hours}) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(hours, style: const TextStyle(color: AppColors.subtext)),
        ],
      ),
    );
  }

  // ───────────────────────────────── Location
  Widget _locationsSection(Doctor d) {
    return Card(
      elevation: 0,
      color: AppColors.bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            kGap12,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: d.locations.map(_locPill).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place_outlined, size: 18, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
