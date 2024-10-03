import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolmate/colors.dart';

import 'presentation/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Updated constructor

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        textTheme: TextTheme(
          displaySmall: GoogleFonts.lato(
            fontSize: 15,
            color: TextColors.textBodySmallColor,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: GoogleFonts.lato(
            fontSize: 20,
            color: TextColors.textLargeLabelColor,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: GoogleFonts.lato(
            fontSize: 150,
            color: TextColors.textLargeLabelColor,
            fontWeight: FontWeight.w300,
          ),
          bodySmall: GoogleFonts.lato(
            fontSize: 24,
            color: TextColors.textBodySmallColor,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: GoogleFonts.lato(
            fontSize: 40,
            color: TextColors.textBodyLargeColor,
            fontWeight: FontWeight.w900,
          ),
          titleSmall: GoogleFonts.lato(
            fontSize: 15,
            color: TextColors.textBodyLargeColor,
            fontWeight: FontWeight.w900,
          ),
          headlineSmall: GoogleFonts.lato(
            fontSize: 12,
            color: TextColors.textBodySmallColor,
            fontWeight: FontWeight.w900,
          ),
          bodyMedium: GoogleFonts.lato(
            fontSize: 20,
            color: TextColors.textBodyLargeColor,
            fontWeight: FontWeight.w900,
          ),
          displayMedium: GoogleFonts.roboto(
            fontSize: 40,
            color: TextColors.textBodyLargeColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        baseColor: AppColors.neumorphicBackgroundColor,
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: WelcomeScreen(),
    );
  }
}
