import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/providers.dart';
import 'appbar.dart';
import 'app_pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';     // <-- IMPORT AUTH_GATE
import 'auth_service.dart'; // <-- IMPORT AUTH_SERVICE for signout

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CorrectProvider()),
      ],
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

/// This new widget is your main app screen.
/// AuthGate will show this when the user is logged in.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Sign out method
  void _signOut() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Home')),
            const ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
            const Divider(),
            // ADDED THIS:
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: _signOut, // Call the sign out method
            ),
          ],
        ),
      ),
      appBar: CustomAppbar(),
      extendBodyBehindAppBar: true,
      body: HomeScreen(), // Your original home screen
    );
  }
}