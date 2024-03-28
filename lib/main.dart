import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn ? MyHomePage() : CollegeApp(),
  ));
}


class CollegeApp extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _usn = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usn.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that USN.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final String? Function(String?) validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    // Sign out the user from Firebase
    await FirebaseAuth.instance.signOut();

    // Clear the login state in shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Clear any user-related data or state (you may need to add this part)
    // For example, if you have user-specific data in a provider, reset it here

    // Navigate to the login page and remove back navigation history
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // This clears the navigation stack
    );
  } catch (e) {
    print('Error during logout: $e');
  }
}

Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
  try {
    // Query Firestore to find the user document with the provided USN and password
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .where('usn', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // User with matching USN and password found
      // You can add additional checks here if needed

      // Get the user's ID from Firestore
      String loginID = querySnapshot.docs.first.id;

      // Store the login ID in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loginID', loginID); // Store the login ID

      // Navigate to MyHomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );

      // Proceed with your desired actions after successful login
    } else {
      // No matching user found
      print('No user found for the provided USN and password.');
    }
  } catch (e) {
    print('Error during login: $e');
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _usn = TextEditingController();
    final TextEditingController _password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('EWCE'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // College Logo
              Image.asset(
                "assets/image/logo.png", // Replace with your logo image asset
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              // USN Input
              CustomTextField(
                controller: _usn,
                labelText: 'USN',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your USN';
                  }
                  // Add more validation logic if needed
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password Input
              CustomTextField(
                controller: _password,
                labelText: 'Password',
                isPassword: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, call signInWithEmailAndPassword with email and password
                    final email = _usn.text;
                    final password = _password.text;
                    await signInWithEmailAndPassword(email, password, context);
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              // Forgot Password Button
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => newscreen()));
                },
                child: const Text('Forgot Password?'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class newscreen extends StatelessWidget {
  const newscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _usnRegistration = TextEditingController();
    final TextEditingController _passwordRegistration = TextEditingController();
    final TextEditingController _phoneRegistration = TextEditingController();
    final TextEditingController _reenterPasswordRegistration =
    TextEditingController();

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EWCE'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // College Logo
              Image.asset(
                'assets/image/logo.png', // Replace with your logo image asset
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              // USN Input for Registration
              CustomTextField(
                controller: _usnRegistration,
                labelText: 'USN Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your USN';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Phone Number Input for Registration
              CustomTextField(
                controller: _phoneRegistration,
                labelText: 'Phone Number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password Input for Registration
              CustomTextField(
                controller: _passwordRegistration,
                labelText: 'Password',
                isPassword: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Reenter Password Input for Registration
              CustomTextField(
                controller: _reenterPasswordRegistration,
                labelText: 'Re-enter Password',
                isPassword: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please re-enter your password';
                  }
                  if (value != _passwordRegistration.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Verification Button
              // Verification Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Create a new user document in Firestore
                      await FirebaseFirestore.instance.collection('students').doc(_usnRegistration.text).set({
                        'usn': _usnRegistration.text,
                        'phone': _phoneRegistration.text,
                        'password': _passwordRegistration.text,
                        'Re-enter Password': _passwordRegistration.text,// Storing password (not recommended for production)
                        // Add more fields as needed
                      });

                      // Redirect to login page after successful registration
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } catch (e) {
                      print('Error: $e');
                    }
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                ),
                child: const Text('Verify'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
