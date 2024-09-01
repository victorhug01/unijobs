import 'package:flutter/material.dart';
import 'package:unijobs/src/services/authentication_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthenticationService _authService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Seja bem vindo'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(onPressed: (){
              _authService.logOut();
            }, child: const Text('Sair')),
          ),
        ],
      ),
    );
  }
}