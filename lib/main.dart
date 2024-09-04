import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unijobs/firebase_options.dart';
import 'package:unijobs/src/app/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://swqmvhzmtijusbsdsbme.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3cW12aHptdGlqdXNic2RzYm1lIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ4Nzk2MzIsImV4cCI6MjA0MDQ1NTYzMn0.AlKL-hMyu_4DqRuSoqyFfOoJqmAKfue2sK5X8cbKkLY',
  );
  runApp(const MyApp());
}
