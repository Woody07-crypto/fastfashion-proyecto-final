import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/garment.dart';
import '../theme/app_theme.dart';
import '../widgets/garment_card.dart';
import 'add_garment_screen.dart';

class ClosetScreen extends StatefulWidget {
  const ClosetScreen({super.key});

  @override
  State<ClosetScreen> createState() => _ClosetScreenState();
}

class _ClosetScreenState extends State<ClosetScreen> {
  late List<Garment> _garments;
  String _filter = 'Todas';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _garments = List.of(MockData.garments);
  }

  List<Garment> get _filtered {
    return _garments.where((g) {
      final matchesFilter = _filter == 'Todas' ||
          g.categoryLabel == _filter ||
          g.styleLabel == _filter ||
          g.color.toLowerCase() == _filter.toLowerCase();
      final matchesQuery = _query.isEmpty ||
          g.name.toLowerCase().contains(_query.toLowerCase()) ||
          g.color.toLowerCase().contains(_query.toLowerCase());
      return matchesFilter && matchesQuery;
    }).toList();
  }

  Future<void> _openAddForm() async {
    final created = await Navigator.of(context).push<Garment>(
      MaterialPageRoute(builder: (_) => const AddGarmentScreen()),
    );
    if (created != null) {
      setState(() => _garments.insert(0, created));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filters = [
      'Todas',
      'Camisa',
      'Pantalón',
      'Zapatos',
      'Casual',
      'Formal',
      'Deportivo',
      'Azul',
      'Blanco',
      'Negro',
    ];

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          const Text(
            'Mi closet',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: AppTheme.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Carrusel de prendas organizadas por categoría, estilo y color.',
            style: TextStyle(color: AppTheme.ink.withValues(alpha: 0.65)),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar por nombre o color…',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final label = filters[index];
                final selected = label == _filter;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => setState(() => _filter = label),
                  selectedColor: AppTheme.teal.withValues(alpha: 0.18),
                  labelStyle: TextStyle(
                    color: selected ? AppTheme.teal : AppTheme.ink,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${_filtered.length} prendas',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 230,
            child: _filtered.isEmpty
                ? const Center(child: Text('No hay prendas con ese filtro'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) =>
                        GarmentCard(garment: _filtered[index]),
                  ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Por categoría',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...GarmentCategory.values.map((category) {
            final items =
                _garments.where((g) => g.category == category).toList();
            if (items.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.first.categoryLabel,
                    style: TextStyle(
                      color: AppTheme.ink.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) =>
                          GarmentCard(garment: items[index]),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddForm,
        icon: const Icon(Icons.add),
        label: const Text('Agregar prenda'),
      ),
    );
  }
}
