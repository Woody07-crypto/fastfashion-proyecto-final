import 'package:flutter_test/flutter_test.dart';
import 'package:fastfashion/main.dart';

void main() {
  testWidgets('FastFashion muestra shell principal', (tester) async {
    await tester.pumpWidget(const FastFashionApp());
    expect(find.text('FastFashion'), findsOneWidget);
    expect(find.text('Outfit del día'), findsOneWidget);
  });
}
