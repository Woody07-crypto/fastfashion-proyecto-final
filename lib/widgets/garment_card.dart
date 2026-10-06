import 'package:flutter/material.dart';

import '../models/garment.dart';
import '../theme/app_theme.dart';

class GarmentCard extends StatelessWidget {
  final Garment garment;
  final double width;

  const GarmentCard({
    super.key,
    required this.garment,
    this.width = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Color(garment.colorValue).withValues(alpha: 0.35),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Center(
              child: Icon(
                _iconFor(garment.category),
                size: 42,
                color: AppTheme.ink.withValues(alpha: 0.75),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  garment.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${garment.categoryLabel} · ${garment.styleLabel}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.ink.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  garment.color,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(GarmentCategory category) {
    switch (category) {
      case GarmentCategory.camisa:
        return Icons.checkroom_outlined;
      case GarmentCategory.pantalon:
        return Icons.dry_cleaning_outlined;
      case GarmentCategory.zapatos:
        return Icons.snowshoeing_outlined;
      case GarmentCategory.accesorio:
        return Icons.watch_outlined;
    }
  }
}
