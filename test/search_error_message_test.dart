import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frame/pages/error_pages/general_error.dart';
import 'package:frame/search/search_provider.dart';
import 'package:http/http.dart';

void main() {
  test('maps ClientException and NetworkError to a friendly message', () {
    final uri = Uri.parse(
      'https://frame-api-python.fastapicloud.dev/search?query=Deep+Work&type=video',
    );

    expect(
      searchErrorMessage(
        ClientException('NetworkError when attempting to fetch resource.', uri),
      ),
      'Search is temporarily unavailable. The request to the search API failed.',
    );
    expect(
      searchErrorMessage(
        Exception(
          'ClientException: NetworkError when attempting to fetch resource.',
        ),
      ),
      'Search is temporarily unavailable. The request to the search API failed.',
    );
  });

  testWidgets('general error message wraps instead of overflowing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: GeneralErrorScreen(
            errorMesage:
                'Search is temporarily unavailable. The request to the search API failed.',
          ),
        ),
      ),
    );

    expect(
      find.text(
        'Search is temporarily unavailable. The request to the search API failed.',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
