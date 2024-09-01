import 'package:flutter/material.dart';

class NewpostPage extends StatefulWidget {
  const NewpostPage({super.key});

  @override
  State<NewpostPage> createState() => _NewpostPageState();
}

class _NewpostPageState extends State<NewpostPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text('New Post'),
      ),
    );
  }
}