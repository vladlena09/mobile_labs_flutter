import 'package:flutter/material.dart';

void main() => runApp(const CalorieCalculatorApp());

class CalorieCalculatorApp extends StatelessWidget {
  const CalorieCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Calorii',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const CalorieHomePage(),
    );
  }
}

class FoodEntry {
  final String name;
  final double calories;

  FoodEntry({required this.name, required this.calories});
}

class CalorieHomePage extends StatefulWidget {
  const CalorieHomePage({super.key});

  @override
  State<CalorieHomePage> createState() => _CalorieHomePageState();
}

class _CalorieHomePageState extends State<CalorieHomePage> {
  final _foodController = TextEditingController();
  final _calController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<FoodEntry> _entries = [];

  double get _total =>
      _entries.fold(0.0, (sum, e) => sum + e.calories);

  @override
  void dispose() {
    _foodController.dispose();
    _calController.dispose();
    super.dispose();
  }

  void _addEntry() {
    if (_formKey.currentState!.validate()) {
      final name = _foodController.text.trim();
      final calories =
      double.parse(_calController.text.replaceAll(',', '.'));
      setState(() {
        _entries.add(FoodEntry(name: name, calories: calories));
        _foodController.clear();
        _calController.clear();
      });
    }
  }

  void _removeEntry(int index) {
    setState(() => _entries.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator Calorii')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // FORM: 2 TextField-uri
              Form(
                key: _formKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _foodController,
                        decoration: const InputDecoration(
                          labelText: 'Aliment',
                          hintText: 'ex: măr, sandwich',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Introdu numele alimentului';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _calController,
                        decoration: const InputDecoration(
                          labelText: 'Calorii',
                          hintText: 'ex: 95',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType:
                        const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Introdu calorii';
                          }
                          final s = v.replaceAll(',', '.');
                          final val = double.tryParse(s);
                          if (val == null || val <= 0) {
                            return 'Valoare invalidă';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _addEntry(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ElevatedButton pentru adăugare
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addEntry,
                  icon: const Icon(Icons.add),
                  label: const Text('Adaugă'),
                ),
              ),

              const SizedBox(height: 16),

              // Total calorii
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total calorii consumate',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    _total.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // ListView pentru afișare listă
              Expanded(
                child: _entries.isEmpty
                    ? const Center(
                  child: Text('Lista e goală. Adaugă primul aliment!'),
                )
                    : ListView.separated(
                  itemCount: _entries.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final e = _entries[index];
                    return Dismissible(
                      key: ValueKey('${e.name}-$index'),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(Icons.delete),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(Icons.delete),
                      ),
                      onDismissed: (_) => _removeEntry(index),
                      child: ListTile(
                        title: Text(e.name),
                        trailing:
                        Text('${e.calories.toStringAsFixed(0)} kcal'),
                        onLongPress: () => _removeEntry(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
