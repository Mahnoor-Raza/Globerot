import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'home.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAD7D7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back_ios, color: Colors.black87),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Sign In Now",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please sign in to continue our app",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "jacklinsmith@gmail.com",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  validator: (value) {
                    if (value == null ||
                        !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$")
                            .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "***********",
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forget Password?",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ),

                const SizedBox(height: 20),
                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomePage(
                              email: _emailController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF973232),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Sign In"),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Don’t have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                const Center(child: Text("Or connect")),
                const SizedBox(height: 20),

                // Social icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.facebook, color: Colors.blue),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, color: Colors.pink),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.alternate_email, color: Colors.lightBlue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
