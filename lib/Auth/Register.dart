// Auth/Register.dart
import 'package:flutter/material.dart';
// นำเข้าไฟล์หน้า Login และ SignUp
import 'LoginPage.dart';
import 'SignUpScreen.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome Title
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Illustration
              Image.asset(
                'images/logo.png', // Replace with your illustration
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 30),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  // นำทางไปยังหน้า LoginPage
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const LoginPage())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  side: const BorderSide(color: Colors.blue),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // นำทางไปยังหน้า SignUpScreen
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const SignUpScreen())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}