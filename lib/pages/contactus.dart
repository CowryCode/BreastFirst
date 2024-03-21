import 'package:breastfirst/api/network.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _emailController = TextEditingController();
  bool _shareSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Contact US"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle done button press
            },
            child: Text("Done"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Let us know what you think about our project",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "... what do you think?",
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if(_emailController.text.isEmpty){
                    _showSnackBar(context);
                  }else{
                    ApiAccess().saveFeedBack(feedback: "${_emailController.text.toString().trim()}");
                    Navigator.pop(context);
                    setState(() {
                      _shareSuccess = true;
                    });
                  }
                },
                child: Text("Send"),
              ),
              // if (_shareSuccess) ...[
              //   SizedBox(height: 16),
              //   Text(
              //     "Share success. User ${_emailController.text} will see My baby after logged in EasyFeed",
              //     style: TextStyle(fontSize: 16),
              //   ),
              //   SizedBox(height: 16),
              //   ElevatedButton(
              //     onPressed: () {
              //       // Handle tell him/her to download
              //     },
              //     child: Text("Tell him/her to download"),
              //   ),
              // ]
            ],
          ),
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("You can\'t submit an empty feedback"),
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