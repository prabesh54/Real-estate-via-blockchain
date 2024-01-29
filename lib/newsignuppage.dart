import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';


class SignupPage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    hintText: 'Country',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: 'City',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Location',
                    prefixIcon: Icon(Icons.map),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () async {
                    
                    await _handleSignup(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );

                  },
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate back to the login page
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignup(BuildContext context) async {
  try {
    // Perform signup logic
    if (_passwordController.text != _confirmPasswordController.text) {
      // Passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (userCredential != null && userCredential.user != null) {
      // Registration successful
      print('User registered: ${userCredential.user!.email}');

      // Save additional user information to Firestore
      String? userId = userCredential.user!.uid;
      if (userId != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'username': _usernameController.text,
          'phone': _phoneController.text,
          'country': _countryController.text,
          'city': _cityController.text,
          'location': _locationController.text,
        });
      } else {
        // Handle the case where userCredential.user.uid is null
        print('Failed to get user ID from FirebaseAuth.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register. Please try again later.')),
        );
        return;
      }

      // Navigate to the Login Page only if registration is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );

      // Show a styled success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check, color: Colors.green),
              SizedBox(width: 8),
              Text('Registration successful!', style: TextStyle(color: Colors.green)),
            ],
          ),
          backgroundColor: Colors.black87,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Something went wrong
      print('Failed to register user: User or UserCredential is null');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register. Please try again later.')),
      );
    }
  } on FirebaseAuthException catch (e) {
    // Registration failed
    print('Failed to register user: ${e.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to register: ${e.message}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


}

