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
          buildListTile('Sleep'),
          buildListTile('Height'),
          buildListTile('Weight'),
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
          buildListTile('Suggestion'),
          buildListTile('Background color'),
          buildListTile('Share with family/friend'),
          buildListTile('Help & support'),
          buildListTile('Send feedback'),
          ListTile(title: Text('App version')),
        ],
      ),
    );
  }

  ListTile buildListTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle list tile tap
      },
    );
  }
}