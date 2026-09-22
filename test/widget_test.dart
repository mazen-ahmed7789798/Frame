// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frame/screens/search_screens_bodys/desktop_body.dart';
import 'package:frame/widgets/suggestion_button.dart';

void main() {
  testWidgets('desktop suggestions render next to Try and use grey commas', (
    WidgetTester tester,
  ) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: DesktopBody(
          controller: controller,
          suggestions: [
            SuggestionButton(suggestionText: 'Focus', controller: controller),
            SuggestionButton(
              suggestionText: 'Deep Work',
              controller: controller,
            ),
            SuggestionButton(
              suggestionText: 'Motivation',
              controller: controller,
            ),
          ],
        ),
      ),
    );

    expect(find.text('Try:'), findsOneWidget);
    expect(find.text('Focus'), findsOneWidget);
    expect(find.text('Deep Work'), findsOneWidget);
    expect(find.text('Motivation'), findsOneWidget);
    expect(find.text(','), findsNWidgets(2));
  });
}
