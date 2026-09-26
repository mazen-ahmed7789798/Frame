import "package:flutter/material.dart";
import 'package:frame/network/network_provider.dart';
import "package:frame/network/network_status_service.dart";
import 'package:frame/router/app_router.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:provider/provider.dart';
import 'package:frame/search/search_provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(
          create: (_) => NetworkProvider(NetworkService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final network = NetworkService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xff7ee7c6),
          selectionColor: Color(0xff7ee7c6),
          selectionHandleColor: Color(0xff7ee7c6),
        ),
        scaffoldBackgroundColor: Color(0xFF0E131A),
        colorScheme: ColorScheme(
          primary: Color(0xFF7EE7C6),
          brightness: Brightness.dark,
          secondary: Color(0xFF1C232B),
          onPrimary: Color(0xFF1C232B),
          onSecondary: Color(0xFF7EE7C6),
          surface: Color(0xFF1C232B),
          error: Colors.red,
          onError: Colors.black,
          onSurface: Color(0xFFE6ECEF),
        ),
        fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
