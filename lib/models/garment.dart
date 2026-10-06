enum GarmentCategory { camisa, pantalon, zapatos, accesorio }

enum GarmentStyle { casual, formal, deportivo }

class Garment {
  final String id;
  final String name;
  final GarmentCategory category;
  final GarmentStyle style;
  final String color;
  final String? notes;
  final int colorValue;

  const Garment({
    required this.id,
    required this.name,
    required this.category,
    required this.style,
    required this.color,
    this.notes,
    required this.colorValue,
  });

  String get categoryLabel {
    switch (category) {
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

  String get styleLabel {
    switch (style) {
      case GarmentStyle.casual:
        return 'Casual';
      case GarmentStyle.formal:
        return 'Formal';
      case GarmentStyle.deportivo:
        return 'Deportivo';
    }
  }
}
