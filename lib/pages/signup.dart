import 'package:breastfirst/pages/addbaby_page2.dart';
import 'package:breastfirst/pages/welcomepage.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _selectedStatus;
  bool _isAgreedToTnC = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Create an account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password*",
                filled: true,
                fillColor: Colors.purple[50],
              ),
            ),
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
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                //String sel = (_selectedStatus == '0') ? "Pregnant Selected" : "Breastfeading selected" ;
                if(_selectedStatus == '0'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()),);
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyDetailsPage()),);
                }
              },
              child: Text("CREATE ACCOUNT"),
            ),
            SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () {
                  // Handle navigation to Sign In screen
                },
                child: Text("Already have an account? Sign in"),
              ),
            )
          ],
        ),
      ),
    );
  }
}