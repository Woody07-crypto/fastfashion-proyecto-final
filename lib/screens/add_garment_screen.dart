import 'package:flutter/material.dart';

import '../models/garment.dart';
import '../theme/app_theme.dart';

/// Formulario refactorizado con Form, GlobalKey, TextFormField y validator.
/// Al menos tres campos rechazan datos inválidos antes de guardar:
/// 1) Nombre  2) Color  3) Notas
class AddGarmentScreen extends StatefulWidget {
  const AddGarmentScreen({super.key});

  @override
  State<AddGarmentScreen> createState() => _AddGarmentScreenState();
}

class _AddGarmentScreenState extends State<AddGarmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _notesController = TextEditingController();

  GarmentCategory _category = GarmentCategory.camisa;
  GarmentStyle _style = GarmentStyle.casual;

  static final _colorPattern = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]{3,20}$');

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'El nombre es obligatorio';
    if (text.length < 3) return 'Usa al menos 3 caracteres';
    if (text.length > 40) return 'Máximo 40 caracteres';
    return null;
  }

  String? _validateColor(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'El color es obligatorio';
    if (!_colorPattern.hasMatch(text)) {
      return 'Solo letras (3–20). Rechaza números o símbolos';
    }
    return null;
  }

  String? _validateNotes(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Agrega una nota breve (mín. 5 caracteres)';
    if (text.length < 5) return 'La nota debe tener al menos 5 caracteres';
    if (text.length > 120) return 'Máximo 120 caracteres';
    return null;
  }

  int _colorValueFromName(String color) {
    final key = color.toLowerCase().trim();
    const map = {
      'azul': 0xFF1565C0,
      'blanco': 0xFFEEEEEE,
      'negro': 0xFF212121,
      'beige': 0xFFD7CCC8,
      'gris': 0xFF9E9E9E,
      'rojo': 0xFFC62828,
      'verde': 0xFF2E7D32,
      'café': 0xFF6D4C41,
      'cafe': 0xFF6D4C41,
    };
    return map[key] ?? 0xFF90A4AE;
  }

  void _save() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Corrige los campos inválidos antes de guardar'),
        ),
      );
      return;
    }

    final garment = Garment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      category: _category,
      style: _style,
      color: _colorController.text.trim(),
      notes: _notesController.text.trim(),
      colorValue: _colorValueFromName(_colorController.text),
    );
    Navigator.of(context).pop(garment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar prenda')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Registro de prenda',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Validación con Form + GlobalKey + TextFormField.',
              style: TextStyle(color: AppTheme.ink.withValues(alpha: 0.65)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Nombre de la prenda',
                hintText: 'Ej. Camisa azul oxford',
                prefixIcon: Icon(Icons.checkroom_outlined),
              ),
              validator: _validateName,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _colorController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Color',
                hintText: 'Ej. Azul',
                prefixIcon: Icon(Icons.palette_outlined),
              ),
              validator: _validateColor,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              maxLength: 120,
              decoration: const InputDecoration(
                labelText: 'Notas / ocasión',
                hintText: 'Ej. Ideal para oficina',
                prefixIcon: Icon(Icons.notes_outlined),
                alignLabelWithHint: true,
              ),
              validator: _validateNotes,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<GarmentCategory>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: GarmentCategory.values
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(_labelCategory(c)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<GarmentStyle>(
              initialValue: _style,
              decoration: const InputDecoration(
                labelText: 'Estilo',
                prefixIcon: Icon(Icons.style_outlined),
              ),
              items: GarmentStyle.values
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(_labelStyle(s)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _style = value);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Guardar prenda'),
            ),
            const SizedBox(height: 10),
            Text(
              'Prueba rechazar: nombre vacío, color "123", nota "ok".',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.ink.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _labelCategory(GarmentCategory c) {
    switch (c) {
      case GarmentCategory.camisa:
        return 'Camisa';
      case GarmentCategory.pantalon:
        return 'Pantalón';
      case GarmentCategory.zapatos:
        return 'Zapatos';
      case GarmentCategory.accesorio:
        return 'Accesorio';
    }
  }

  String _labelStyle(GarmentStyle s) {
    switch (s) {
      case GarmentStyle.casual:
        return 'Casual';
      case GarmentStyle.formal:
        return 'Formal';
      case GarmentStyle.deportivo:
        return 'Deportivo';
    }
  }
}
