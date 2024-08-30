import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unijobs/firebase_options.dart';
import 'package:unijobs/src/app/myapp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}