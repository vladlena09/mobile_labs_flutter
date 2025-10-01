import 'package:flutter/material.dart';
import 'package:med_app_ui/theme.dart';
import 'package:med_app_ui/models.dart';
import 'package:med_app_ui/widgets/category_pill.dart';
import 'package:med_app_ui/widgets/specialist_card.dart';
import 'package:med_app_ui/screens/doctor_detail_screen.dart';
import 'package:med_app_ui/widgets/quick_actions_section.dart';
import 'package:med_app_ui/widgets/rect_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _specialties = const [
    (Icons.remove_red_eye_outlined, 'Eye Specialist'),
    (Icons.medical_services_outlined, 'Dentist'),
    (Icons.favorite_border, 'Cardiologist'),
    (Icons.air_outlined, 'Pulmonologist'),
    (Icons.psychology_alt_outlined, 'Physician'),
  ];

  int selectedSpecialty = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(context),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _searchRow(),
          kGap16,
          const QuickActionsSection(), // 2 sus + 3 jos, ca în mock
          kGap16,
          Text(
            'Specialities most relevant to you',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          kGap12,
          _specialtyChips(),
          kGap16,
          _specialistsSection(context),
        ],
      ),
    );
  }

  // ───────────────────────── AppBar
  PreferredSizeWidget _topBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      elevation: 0.5,
      shadowColor: Colors.black12,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanvir Ahassan',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                Text('Mirpur, Dhaka',
                    style: TextStyle(fontSize: 12, color: AppColors.subtext)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── Search + buton pătrat din dreapta
  Widget _searchRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        RectIconButton(
          icon: Icons.filter_list_rounded,
          onTap: () {},
        ),
      ],
    );
  }

  // ───────────────────────── Bulele cu specialități
  Widget _specialtyChips() {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _specialties.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final (icon, label) = _specialties[i];
          return CategoryPill(
            icon: icon,
            label: label,
            selected: selectedSpecialty == i,
            onTap: () => setState(() => selectedSpecialty = i),
          );
        },
      ),
    );
  }

  // ───────────────────────── Secțiunea „Specialists”
  Widget _specialistsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Specialists',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('View all  >')),
          ],
        ),
        kGap12,
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) {
              final asset =
              i == 0 ? 'assets/images/spec_gp1.jpg' : 'assets/images/spec_gp2.jpg';
              return SpecialistCard(
                asset: asset,
                title: 'General Practitioners',
                fav: i == 0,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DoctorDetailScreen(doctor: demoDoctor),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
