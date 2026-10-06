/// VERSIÓN ANTERIOR (sin Form) — referencia de la actividad de refactorización.
///
/// Problemas detectados:
/// - No usaba Form ni GlobalKey.
/// - TextField sin validator: aceptaba nombre vacío, color inválido y notas
///   demasiado largas.
/// - El botón Guardar no bloqueaba datos inválidos.
///
/// Este archivo NO se usa en la app. Queda como evidencia del estado previo.
library;

import 'package:flutter/material.dart';

import '../models/garment.dart';

class AddGarmentScreenAntes extends StatefulWidget {
  const AddGarmentScreenAntes({super.key});

  @override
  State<AddGarmentScreenAntes> createState() => _AddGarmentScreenAntesState();
}

class _AddGarmentScreenAntesState extends State<AddGarmentScreenAntes> {
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _notesController = TextEditingController();
  final GarmentCategory _category = GarmentCategory.camisa;
  final GarmentStyle _style = GarmentStyle.casual;

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    // Sin validación: guardaba aunque los campos estuvieran vacíos o inválidos.
    Navigator.of(context).pop(
      Garment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        category: _category,
        style: _style,
        color: _colorController.text,
        notes: _notesController.text,
        colorValue: 0xFF90A4AE,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar prenda (antes)')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _colorController,
            decoration: const InputDecoration(labelText: 'Color'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notas'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: const Text('Guardar')),
        ],
      ),
    );
  }
}
