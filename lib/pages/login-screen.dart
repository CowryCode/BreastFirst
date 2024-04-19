
import 'package:breastfirst/api/FireStoreAuthentication.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/pages/homepage.dart';
import 'package:breastfirst/pages/signup.dart';
import 'package:breastfirst/pages/welcomepage.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget content(){
    return SingleChildScrollView(
      child: Padding(
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

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _loginAction().then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                  if (value == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    _showSnackBar(context);
                  }
                });
              },
              child: _isLoading ? CircularProgressIndicator() : Text('Log in'),
              style: ElevatedButton.styleFrom(primary: Colors.purple),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _loginAction().then((value) => {
            //       if(value == true){
            //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()),)
            //       }else{
            //         _showSnackBar(context)
            //       }
            //     });
            //   },
            //   child: Text('Log in'),
            //   style: ElevatedButton.styleFrom(primary: Colors.purple),
            // ),
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
      ),
    );
  }

  Future<bool> _loginAction() async{
    //if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
    if(_emailController.text.isEmpty){
      return false;
    }else{
      print(_emailController.text.toString());

      // bool _ispregant = (_selectedStatus == '0') ? true : false;

    return FireStoreAuthentication().signInUser(
          email: _emailController.text.toString().trim(),
         // password: _passwordController.text.toString().trim(),
      );
    }
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Check Email and Password'),
      action: SnackBarAction(
        label: 'Warning',
        onPressed: () {
          // Perform some action when the "Close" button is pressed.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}