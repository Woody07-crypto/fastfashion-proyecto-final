import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/garment.dart';
import '../theme/app_theme.dart';
import '../widgets/garment_card.dart';
import '../widgets/weather_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Garment> _outfit;
  bool _generating = false;
  int _seed = 0;

  @override
  void initState() {
    super.initState();
    _outfit = _buildOutfit();
  }

  List<Garment> _buildOutfit() {
    final items = MockData.garments;
    final camisa = items
        .where((g) => g.category == GarmentCategory.camisa)
        .elementAt(_seed % 3);
    final pantalon = items
        .where((g) => g.category == GarmentCategory.pantalon)
        .elementAt(_seed % 2);
    final zapatos = items
        .where((g) => g.category == GarmentCategory.zapatos)
        .elementAt(_seed % 2);
    return [camisa, pantalon, zapatos];
  }

  Future<void> _regenerate() async {
    setState(() => _generating = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    setState(() {
      _seed++;
      _outfit = _buildOutfit();
      _generating = false;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nuevo outfit generado en menos de 5 s')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const Text(
          'Outfit del día',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.ink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Combinaciones rápidas según tu closet, gustos y clima.',
          style: TextStyle(color: AppTheme.ink.withValues(alpha: 0.65)),
        ),
        const SizedBox(height: 16),
        const WeatherBanner(weather: MockData.weather),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sugerencia actual',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.ink,
              ),
            ),
            TextButton.icon(
              onPressed: _generating ? null : _regenerate,
              icon: _generating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: Text(_generating ? 'Generando…' : 'Regenerar'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _outfit.length,
            itemBuilder: (context, index) => GarmentCard(garment: _outfit[index]),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Por qué esta combinación',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'La IA priorizó prendas ligeras por el clima soleado (28°C) '
                'y un estilo mixto casual/formal para estudio o trabajo.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
