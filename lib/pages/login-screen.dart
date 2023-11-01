
import 'package:breastfirst/pages/signup.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Text(
              'EasyFeed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email*',
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password*',
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle login logic
            },
            child: Text('Log in'),
            style: ElevatedButton.styleFrom(primary: Colors.purple),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('OR')],
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Handle Facebook login
            },
            icon: Icon(Icons.facebook, color: Colors.blue),
            label: Text('Sign in with Facebook'),
            style: ElevatedButton.styleFrom(primary: Colors.purple),
          ),
          SizedBox(height: 20),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    // Navigate to sign up page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()),);
                  },
                  child: Text('Sign up', style: TextStyle(color: Colors.purple)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}