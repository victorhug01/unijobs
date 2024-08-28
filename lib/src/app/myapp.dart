import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unijobs/src/screens/login/login_authetication.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unijobs',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0072bc)),
        useMaterial3: true,
      ),
      home: const LoginAuthentication(),
    );
  }
}
