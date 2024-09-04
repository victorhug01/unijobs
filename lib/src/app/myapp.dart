import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unijobs/src/views/forgotpassword/forgotpassword.dart';
import 'package:unijobs/src/views/login/login_authetication.dart';
import 'package:unijobs/src/views/navigation/navigation_bar_controller.dart';
import 'package:unijobs/src/views/register/register_authentication.dart';

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
          // print('id: ${snapshot.data!.uid.toString()}');
          // print('Nome: ${snapshot.data!.displayName.toString()}');
          // print('Email: ${snapshot.data!.email.toString()}');
          // print('Email: ${snapshot.data!.phoneNumber.toString()}');
          return const NavigationBottomNavigation();
        }else{
          return const LoginAuthentication();
        }
      },
    );
  }
}
