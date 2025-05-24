import 'package:flutter/material.dart';
import 'sign_in.dart';

class LandingScreen2 extends StatelessWidget {
  const LandingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAD7D7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Image.asset(
              "assets/images/travel_main.png", // replace with your image path
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 30),

          // Headline Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Life’s too short to stay\nin one place",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                height: 1.3,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Description Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Welcome to Globetrot — your travel companion! Plan, explore, and experience the world with ease. Let’s start your adventure — where to next?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Indicators (Mocked for now)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle, size: 10, color: Colors.blueAccent),
              SizedBox(width: 8),
              Icon(Icons.circle, size: 10, color: Color(0xFFCCCCCC)),
            ],
          ),

          const Spacer(),

          // Get Started Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
              onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF973232),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
