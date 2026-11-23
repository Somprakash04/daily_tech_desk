import 'package:daily_tech_desk/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('DailyTechDeskApp initializes and renders root widget', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const DailyTechDeskApp());
    await tester.pump();

    // Verify root MaterialApp.router widget exists
    expect(find.byType(DailyTechDeskApp), findsOneWidget);
  });
}
