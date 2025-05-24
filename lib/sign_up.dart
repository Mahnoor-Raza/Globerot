import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAD7D7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Sign Up Now",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please fill the details and create account",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF973232)),
                ),
                const SizedBox(height: 40),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Jacklin Smith",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "jacklinsmith@gmail.com",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
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
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "***********",
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
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
                    if (value == null ||
                        value.length < 6 ||
                        !RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
                      return "Password must be at least 6 characters & 1 symbol";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  "Password must be 8 character and one symbol",
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signed up successfully")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF973232),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 20),

                // Already have account
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account ",
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(child: Text("Or connect")),
                const SizedBox(height: 20),

                // Social media icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.camera_alt, color: Colors.pink),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.facebook, color: Colors.blue),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.alternate_email, color: Colors.lightBlue),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
