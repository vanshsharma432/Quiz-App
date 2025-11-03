import 'package:firebase_auth/firebase_auth.dart'; // <-- Add this import
import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../auth_text_field.dart';
import '../appfonts.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (_isLoading) return;

    // --- NEW: Check for empty fields ---
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // ---------------------------------

    setState(() => _isLoading = true);

    try {
      // We don't need to trim() anymore if we check for empty
      await _authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      // The AuthGate will handle navigation on success
    } on FirebaseAuthException catch (e) {
      // --- NEW: Catch the specific Firebase error ---
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // Use the specific error message from Firebase
          content: Text(e.message ?? "Login failed. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        // ... (your existing gradient decoration)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: width>600 ? 500 : double.infinity,
              // ... (your existing card decoration)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.all(24.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                // ... (your existing Column)
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Welcome Back!",
                    textAlign: TextAlign.center,
                    style: Appfonts.medbodybold.copyWith(fontSize: height * 0.03),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Login to continue",
                    textAlign: TextAlign.center,
                    style: Appfonts.medbody.copyWith(fontSize: height * 0.02, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 32),
                  AuthTextField(
                    controller: _emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _signIn, // This now works!
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text("Login", style: Appfonts.smallbodybold.copyWith(fontSize: height * 0.02)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member? ", style: Appfonts.medbody),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register now",
                          style: Appfonts.medbodybold.copyWith(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}