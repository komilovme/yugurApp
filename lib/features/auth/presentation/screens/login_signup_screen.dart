import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Login / Signup', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 12),
                  const TextField(decoration: InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 8),
                  const TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
