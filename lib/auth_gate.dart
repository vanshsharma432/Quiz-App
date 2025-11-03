import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'loading.dart';
import 'login_or_signup.dart';
import 'screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // User is not logged in
        if (!snapshot.hasData) {
          // Show the login/signup toggle page
          return const LoginOrSignUp(); // <-- USE YOUR NEW WIDGET HERE
        }

        // Stream is still loading (This is a good fallback)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading(); 
        }

        // User is logged in, show the loading screen to fetch questions
        return  HomeScreen();
      },
    );
  }
}