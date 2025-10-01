class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String degree;
  final double rating;
  final int yearsOfWork;
  final int patients;
  final String avatarUrl;
  final List<String> locations;
  final Map<String, List<String>> slotsByDay;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.degree,
    required this.rating,
    required this.yearsOfWork,
    required this.patients,
    required this.avatarUrl,
    required this.locations,
    required this.slotsByDay,
  });

  Doctor copyWith({
    String? id,
    String? name,
    String? specialty,
    String? degree,
    double? rating,
    int? yearsOfWork,
    int? patients,
    String? avatarUrl,
    List<String>? locations,
    Map<String, List<String>>? slotsByDay,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      degree: degree ?? this.degree,
      rating: rating ?? this.rating,
      yearsOfWork: yearsOfWork ?? this.yearsOfWork,
      patients: patients ?? this.patients,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      locations: locations ?? this.locations,
      slotsByDay: slotsByDay ?? this.slotsByDay,
    );
  }
}

// date demo
final demoDoctor = Doctor(
  id: 'd1',
  name: 'Dr. Emma Kathrin',
  specialty: 'Cardiologist',
  degree: 'MBBS',
  rating: 4.3,
  yearsOfWork: 14,
  patients: 125,
  avatarUrl: 'https://i.pravatar.cc/150?img=47',
  locations: [
    'Evercare Hospital Ltd., Bashundhara, Dhaka',
    'Shahbag, BSSMU',
  ],
  slotsByDay: {
    'Today': [],
    'Tomorrow': ['06:00 - 06:30', '06:30 - 07:00', '07:00 - 07:30'],
    '17 Oct': ['06:00 - 06:30', '06:30 - 07:00'],
  },
);
