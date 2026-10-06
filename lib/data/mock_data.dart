import '../models/garment.dart';

class MockWeather {
  final String city;
  final double temperatureC;
  final String condition;
  final String advice;

  const MockWeather({
    required this.city,
    required this.temperatureC,
    required this.condition,
    required this.advice,
  });
}

class MockData {
  static const weather = MockWeather(
    city: 'San Salvador',
    temperatureC: 28,
    condition: 'Soleado',
    advice: 'Prefiere telas ligeras y colores claros.',
  );

  static final List<Garment> garments = [
    const Garment(
      id: '1',
      name: 'Camisa azul oxford',
      category: GarmentCategory.camisa,
      style: GarmentStyle.formal,
      color: 'Azul',
      colorValue: 0xFF1565C0,
      notes: 'Ideal para oficina',
    ),
    const Garment(
      id: '2',
      name: 'Camisa blanca lino',
      category: GarmentCategory.camisa,
      style: GarmentStyle.casual,
      color: 'Blanco',
      colorValue: 0xFFEEEEEE,
    ),
    const Garment(
      id: '3',
      name: 'Pantalón chino beige',
      category: GarmentCategory.pantalon,
      style: GarmentStyle.casual,
      color: 'Beige',
      colorValue: 0xFFD7CCC8,
    ),
    const Garment(
      id: '4',
      name: 'Pantalón negro vestir',
      category: GarmentCategory.pantalon,
      style: GarmentStyle.formal,
      color: 'Negro',
      colorValue: 0xFF212121,
    ),
    const Garment(
      id: '5',
      name: 'Zapatos cafe',
      category: GarmentCategory.zapatos,
      style: GarmentStyle.formal,
      color: 'Café',
      colorValue: 0xFF6D4C41,
    ),
    const Garment(
      id: '6',
      name: 'Tenis blancos',
      category: GarmentCategory.zapatos,
      style: GarmentStyle.deportivo,
      color: 'Blanco',
      colorValue: 0xFFF5F5F5,
    ),
    const Garment(
      id: '7',
      name: 'Polo gris',
      category: GarmentCategory.camisa,
      style: GarmentStyle.deportivo,
      color: 'Gris',
      colorValue: 0xFF9E9E9E,
    ),
    const Garment(
      id: '8',
      name: 'Cinturón negro',
      category: GarmentCategory.accesorio,
      style: GarmentStyle.formal,
      color: 'Negro',
      colorValue: 0xFF424242,
    ),
  ];
}
