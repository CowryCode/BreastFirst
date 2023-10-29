import 'package:flutter/material.dart';

class LullabiesScreen extends StatefulWidget {
  @override
  _LullabiesScreenState createState() => _LullabiesScreenState();
}

class _LullabiesScreenState extends State<LullabiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("LULLABIES 🎵"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle play button press
                  },
                  child: Text('Play'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle shuffle button press
                  },
                  child: Text('Shuffle'),
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(title: Text('Rock-a-Bye Baby')),
                  ListTile(title: Text('Twinkle Twinkle Little Star')),
                  ListTile(title: Text('Amazing Grace')),
                  ListTile(title: Text('Goodnight Sweetheart Goodnight')),
                  ListTile(title: Text('Brahms\' Lullaby')),
                  ListTile(title: Text('Brother John')),
                  ListTile(title: Text('Swing Low, Sweet Chariot')),
                  ListTile(title: Text('Star Light, Star Bright')),
                  ListTile(title: Text('Somewhere Over the Rainbow')),
                  ListTile(title: Text('All the Pretty Little Horses')),
                  ListTile(title: Text('You Are My Sunshine')),
                  ListTile(title: Text('Hush Little Baby')),
                  ListTile(title: Text('Row Row Row Your Boat')),
                  ListTile(title: Text('Isn\'t She Lovely')),
                  ListTile(title: Text('Beautiful Boy')),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home, size: 30),
                Icon(Icons.library_music, size: 30),
                Icon(Icons.playlist_play, size: 30),
                Icon(Icons.search, size: 30),
              ],
            )
          ],
        ),
      ),
    );
  }
}