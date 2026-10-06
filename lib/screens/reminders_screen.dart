import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool _morningReminder = true;
  bool _smartReminder = true;
  TimeOfDay _time = const TimeOfDay(hour: 6, minute: 45);

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const Text(
          'Recordatorios',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.ink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Configura avisos para consultar el outfit del día.',
          style: TextStyle(color: AppTheme.ink.withValues(alpha: 0.65)),
        ),
        const SizedBox(height: 20),
        SwitchListTile(
          value: _morningReminder,
          onChanged: (v) => setState(() => _morningReminder = v),
          activeThumbColor: AppTheme.teal,
          title: const Text('Recordatorio matutino'),
          subtitle: Text(
            'Avisarme a las ${_time.format(context)}',
          ),
          secondary: const Icon(Icons.alarm),
        ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text('Hora del recordatorio'),
          trailing: TextButton(
            onPressed: _morningReminder ? _pickTime : null,
            child: Text(_time.format(context)),
          ),
        ),
        const Divider(),
        SwitchListTile(
          value: _smartReminder,
          onChanged: (v) => setState(() => _smartReminder = v),
          activeThumbColor: AppTheme.teal,
          title: const Text('Recordatorio inteligente'),
          subtitle: const Text(
            'Cuando el algoritmo detecte que toca un nuevo outfit.',
          ),
          secondary: const Icon(Icons.auto_awesome),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Text(
            'Mockup: los recordatorios se simulan localmente. '
            'En la versión final se conectarían a notificaciones del sistema.',
          ),
        ),
      ],
    );
  }
}
