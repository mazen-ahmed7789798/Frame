import "package:flutter/material.dart";
import "package:frame/network/network_status_service.dart";
import 'package:frame/screens/search_screen.dart';
import "package:google_fonts/google_fonts.dart";

void main() async {
  runApp(MyApp());
  final network = NetworkService();
  final status = await network.check();
  print(status);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final network = NetworkService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1C232B),
        colorScheme: ColorScheme(
          primary: Color(0xFF7EE7C6),
          brightness: Brightness.dark,
          secondary: Color(0xFF1C232B),
          onPrimary: Color(0xFF1C232B),
          onSecondary: Color(0xFF7EE7C6),
          surface: Color(0xFF1C232B),
          error: Colors.red,
          onError: Colors.black,
          onSurface: Colors.black,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
      ),

      home: SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
