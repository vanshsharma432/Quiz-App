import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers.dart';
import 'app_pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CorrectProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppPallete.primary,
        fontFamily: 'Fredoka',
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthGate(), // <-- This is the main change
    );
  }
}
