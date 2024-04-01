import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvitationScreen extends StatefulWidget {
  @override
  _InvitationScreenState createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  bool _shareSuccess = false;

  @override
  Widget build(BuildContext context) {
   // String? USERid = motherDataNotifier.value.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Invitation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle done button press
            },
            child: Text(""),
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
                "Let him/her track My baby's nursing with you:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
                keyboardType: TextInputType.text, // Set keyboard type to number
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.purple[50],
                ),
                keyboardType: TextInputType.emailAddress, // Set keyboard type to number
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._]')),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if(_nameController.text.isEmpty || _emailController.text.isEmpty){
                    _showSnackBar(context, note: 'All fields should be filled');
                  }else{
                    FireStoreConnect().shareProgress(user: _emailController.text.toString().trim(), name: _nameController.text.toString().trim());
                    _showSnackBar(context, note: 'You have successfully shared your progress');
                    Navigator.pop(context);
                  }
                  setState(() {
                    _shareSuccess = true;
                  });
                },
                child: Text("Send"),
              ),
              Text("You shared your progress with:",
                style: TextStyle(fontSize: 16),
              ),
              ValueListenableBuilder(
              valueListenable: motherDataNotifier,
              builder: (context, Motherdata motherdata, child){
                return  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('ShareCollection').where("sharedBy", isEqualTo: motherdata.email)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('');
                      }
                      if (!snapshot.hasData) {
                        return Text('');
                      } else {
                        if (snapshot.data!.size > 0) {
                          Map<String, dynamic> data = snapshot.data!.docs.first
                              .data() as Map<String, dynamic>;
                          //return Text(data["name"], style: TextStyle(color: Colors.black));
                          return Wrap(
                            children: snapshot.data!.docs.map((
                                DocumentSnapshot document) {
                              if (document == null)
                                return SizedBox(
                                  height: 10,
                                );
                              Map<String, dynamic> data = document.data()! as Map<
                                  String,
                                  dynamic>;
                              //Timestamp timestamp = data['timestamp'];
                              return ElevatedButton(
                                child: Text('${data['sharerToName']}'),
                                onPressed: () {
                                  _confirmDelete(name: '${data['sharerToName']}', sharedBy: '${data['sharedBy']}', sharedTo: '${data['sharedTo']}');
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => BreastfeedingStatsScreen()), Text('${data['name']}')
                                  // );
                                },
                              );
                            }).toList(),
                          );
                        }
                      }
                      return const Text('');
                    });
              }),

              if (_shareSuccess) ...[
                SizedBox(height: 16),
                Text(
                  "You have success fully shared your progress with : \n ${_emailController.text}",
                  style: TextStyle(fontSize: 16),
                ),
              ]

            ],
          ),
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, {required String note}) {
    final snackBar = SnackBar(
      content: Text('$note'),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Perform some action when the "Close" button is pressed.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Object _confirmDelete({ required String name, required String  sharedBy, required String sharedTo}){
    return    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: Text('Do you want to stop sharing progress with $name ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FireStoreConnect().deleteSharing(sharedBy: sharedBy, sharedTo: sharedTo);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}