import 'package:flutter/material.dart';
import 'package:unijobs/src/services/authentication_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthenticationService _authService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
            child: ElevatedButton(
              onPressed: () {
                _authService.logOut();
              },
              child: const Text('Sair'),
            ),
          ),
    );
  }
}