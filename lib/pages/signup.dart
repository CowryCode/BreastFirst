import 'package:breastfirst/api/FireStoreAuthentication.dart';
import 'package:breastfirst/pages/addbaby_page2.dart';
import 'package:breastfirst/pages/login-screen.dart';
import 'package:breastfirst/pages/welcomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  String? _selectedStatus;
  bool _isAgreedToTnC = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Create an account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'EasyFeed',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name*",
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email*",
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
              ),
              // SizedBox(height: 16),
              // TextField(
              //   controller: _passwordController,
              //   obscureText: true,
              //   decoration: InputDecoration(
              //     hintText: "Password*",
              //     filled: true,
              //     fillColor: Colors.purple[50],
              //   ),
              // ),
              SizedBox(height: 20),
              Text("Select status:"),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Pregnant'),
                      leading: Radio<String>(
                        //value: 'Pregnant',
                        value: '0',
                        groupValue: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                          });
                          print('PREGNANT-VALUE IS : $value');
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Breastfeeding'),
                      leading: Radio<String>(
                        // value: 'Breastfeeding',
                        value: '1',
                        groupValue: _selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value;
                            print('BREAST-FEEDING VALUE IS : $value');
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isAgreedToTnC,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAgreedToTnC = value!;
                      });
                    },
                  ),
                  Text("I read and agree to Terms & Conditions")
                ],
              ),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     // Handle registration logic here
              //     String sel = (_selectedStatus == '0')
              //         ? "Pregnant Selected"
              //         : "Breastfeading selected";
              //
              //     _submitAction().then((value) => {
              //           if (value == true)
              //             {
              //               if (_selectedStatus == '0')
              //                 {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) => WelcomePage()),
              //                   )
              //                 }
              //               else
              //                 {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             AddBabyDetailsPage()),
              //                   )
              //                 }
              //             }
              //           else
              //             {_showSnackBar(context)}
              //         });
              //
              //   },
              //   child: Text("CREATE ACCOUNT"),
              // ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });

                  String sel = (_selectedStatus == '0') ? "Pregnant Selected" : "Breastfeeding selected";

                  _submitAction().then((value) {
                    setState(() {
                      _isLoading = false;
                    });

                    if (value == true) {
                      if (_selectedStatus == '0') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomePage()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddBabyDetailsPage()),
                        );
                      }
                    } else {
                      _showSnackBar(context);
                    }
                  });
                },
                child: _isLoading ? CircularProgressIndicator() : Text("CREATE ACCOUNT"),
              ),
              SizedBox(height: 16),
              Center(
                child: InkWell(
                  onTap: () {
                    // Handle navigation to Sign In screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text("Already have an account? Sign in"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _submitAction() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _isAgreedToTnC == false ||
        _selectedStatus == null) {
      return false;
    } else {
      bool _ispregant = (_selectedStatus == '0') ? true : false;
      UserCredential? cred = await FireStoreAuthentication()
          .createMotherAccount(
              email: _emailController.text.toString(),
              // password: _passwordController.text.toString(),
              name: _nameController.text.toString(),
              pregnancyStatus: _ispregant);

      // Future<UserCredential?> cred =  FireStoreAuthentication().createMotherAccount(
      //     email: _emailController.text.toString(),
      //     password: _passwordController.text.toString(),
      //     name: _nameController.text.toString(),
      //     pregnancyStatus: _ispregant
      // );
      // bool result = false;
      // cred.then((value) => {
      //   result = value != null
      // });
      // return result;

      return cred != null;
    }
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
          'Either incomplete form or email address is used already.'),
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
