import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unijobs/src/screens/forgotpassword/forgotpassword.dart';
import 'package:unijobs/src/screens/home/home_page.dart';
import 'package:unijobs/src/screens/login/login_authetication.dart';
import 'package:unijobs/src/screens/register/register_authentication.dart';

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
      initialRoute: '/',
      routes: {
        'forgotPassword': (_) => const ForgotPassword(),
        'registerAuthetication': (_) => const RegisterAuthentication(),
        'loginAuthentication': (_) => const LoginAuthentication(),
        'roteadorScreen': (_) => const RoteadorScreen(),
      },
      home: const RoteadorScreen(),
    );
  }
}

class RoteadorScreen extends StatelessWidget {
  const RoteadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return const MyHomePage();
        }else{
          return const LoginAuthentication();
        }
      },
    );
  }
}
