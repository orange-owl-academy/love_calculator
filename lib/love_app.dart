import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:love_calculator/screens/home_screen.dart';

class LoveApp extends StatelessWidget {
  const LoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.chewyTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
