import 'package:breastfirst/pages/addbaby_page1.dart';
import 'package:breastfirst/pages/addbaby_page3.dart';
import 'package:breastfirst/pages/contactus.dart';
import 'package:breastfirst/pages/invitation.dart';
import 'package:breastfirst/pages/journalInput.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isCelsius = true;
  bool _isCentimeter = true;
  bool _isKilogram = true;
  bool _isMilliliter = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle my babies button press
            },
            child: Text("My babies"),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(title: Text('Growth standards')),
          buildListTile('Sleep', pageID: 0),
          buildListTile('Height', pageID: 1),
          buildListTile('Weight', pageID: 2),
          ListTile(title: Text('Measurement units')),
          SwitchListTile(
            title: Text('Temperature'),
            value: _isCelsius,
            onChanged: (value) {
              setState(() {
                _isCelsius = value;
              });
            },
            secondary: _isCelsius ? Text('°C') : Text('°F'),
          ),
          SwitchListTile(
            title: Text('Height'),
            value: _isCentimeter,
            onChanged: (value) {
              setState(() {
                _isCentimeter = value;
              });
            },
            secondary: _isCentimeter ? Text('cm') : Text('inch'),
          ),
          SwitchListTile(
            title: Text('Weight'),
            value: _isKilogram,
            onChanged: (value) {
              setState(() {
                _isKilogram = value;
              });
            },
            secondary: _isKilogram ? Text('kg') : Text('lb'),
          ),
          SwitchListTile(
            title: Text('Volume'),
            value: _isMilliliter,
            onChanged: (value) {
              setState(() {
                _isMilliliter = value;
              });
            },
            secondary: _isMilliliter ? Text('mL') : Text('fl oz'),
          ),
          buildListTile('Journal', pageID: 3),
          buildListTile('Background color', pageID: 4),
          buildListTile('Share with family/friend', pageID: 5),
          buildListTile('Help & support', pageID: 6),
          buildListTile('Send feedback', pageID: 7),
          ListTile(title: Text('App version 1.0')),
        ],
      ),
    );
  }

  ListTile buildListTile(String title, {required int pageID}) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if(pageID == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage()),);
        }else if(pageID == 2){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage3()),);
        }else if(pageID == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Journal()),);
        }else if(pageID == 4){

        }else if(pageID == 5){
          Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationScreen()),);
        }else if(pageID == 6){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()),);
        }else if(pageID == 7){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()),);
        }
        // Handle list tile tap
      },
    );
  }
}