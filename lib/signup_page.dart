import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        leading: Icon(Icons.account_balance), // Add this line to include the icon in the AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(217, 49, 7, 127), Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.white),
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
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        _togglePasswordVisibility();
                      },
                    ),
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
                    // Add signup functionality
                    await _handleSignup(context);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 180, 184, 188)),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.pop(context);
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
    // Implement signup logic here
    // Example:
    // await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //   email: _emailController.text,
    //   password: _passwordController.text,
    // );

    // Navigate to the dashboard after signup
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RealEstateDashboard()),
    );
  }

  void _togglePasswordVisibility() {
    // Toggle password visibility
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}

class RealEstateDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real Estate Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Real Estate Dashboard'),
      ),
    );
  }
}
