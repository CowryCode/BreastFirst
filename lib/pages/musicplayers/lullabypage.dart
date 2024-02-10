import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:breastfirst/pages/musicplayers/musiclibrary.dart';
import 'package:flutter/material.dart';

class LullabiesScreen extends StatefulWidget {
  @override
  _LullabiesScreenState createState() => _LullabiesScreenState();
}

class _LullabiesScreenState extends State<LullabiesScreen> {

  AudioPlayer player = new AudioPlayer();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId("1");

  bool b = true;

  int activeMusicIndex = 0;
  bool isMusicPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //playBgSound(musicUri: "https://ardanceeappassets.s3.ca-central-1.amazonaws.com/audios/Enjoy-12.mp3");
    //playBgSound(musicUri: "https://easyfeed.s3.us-east-2.amazonaws.com/Rock_a_bye_Baby.mp3");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeAudio();
  }

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
                  //ListTile(title: Text('Rock-a-Bye Baby')),
                  musicItem(musicName: 'Rock-a-Bye Baby' , musicIndex: 1),
                  //ListTile(title: Text('Twinkle Twinkle Little Star')),
                  musicItem(musicName: 'Twinkle Twinkle Little Star' , musicIndex: 2),
                  //ListTile(title: Text('Amazing Grace')),
                  musicItem(musicName: 'Amazing Grace' , musicIndex: 3),
                  // ListTile(title: Text('Goodnight Sweetheart Goodnight')),
                  musicItem(musicName: 'Goodnight Sweetheart Goodnight' , musicIndex: 4),
                  // ListTile(title: Text('Brahms\' Lullaby')),
                  musicItem(musicName: 'Brahms\' Lullaby' , musicIndex: 5),
                  // ListTile(title: Text('Brother John')),
                  musicItem(musicName: 'Brother John' , musicIndex: 6),
                  // ListTile(title: Text('Swing Low, Sweet Chariot')),
                  musicItem(musicName: 'Swing Low, Sweet Chariot' , musicIndex: 7),
                  // ListTile(title: Text('Star Light, Star Bright')),
                  musicItem(musicName: 'Star Light, Star Bright' , musicIndex: 8),
                  //ListTile(title: Text('Somewhere Over the Rainbow')),
                  musicItem(musicName: 'Somewhere Over the Rainbow' , musicIndex: 9),
                  // ListTile(title: Text('All the Pretty Little Horses')),
                  musicItem(musicName: 'All the Pretty Little Horses' , musicIndex: 10),
                  // ListTile(title: Text('You Are My Sunshine')),
                  musicItem(musicName: 'You Are My Sunshine' , musicIndex: 11),
                  // ListTile(title: Text('Hush Little Baby')),
                  musicItem(musicName: 'Hush Little Baby' , musicIndex: 12),
                  // ListTile(title: Text('Row Row Row Your Boat')),
                  musicItem(musicName: 'Row Row Row Your Boat' , musicIndex: 13),
                  //ListTile(title: Text('Isn\'t She Lovely')),
                  musicItem(musicName: 'Isn\'t She Lovely' , musicIndex: 14),
                  // ListTile(title: Text('Beautiful Boy')),
                  musicItem(musicName: 'Beautiful Boy' , musicIndex: 15),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //    // Icon(Icons.home, size: 30),
            //     // Icon(Icons.library_music, size: 30),
            //     // Icon(Icons.playlist_play, size: 30),
            //     // Icon(Icons.search, size: 30),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget musicItem({required String musicName, required int musicIndex}){
    return ListTile(
      title: ElevatedButton(
        onPressed: () {
          musicSelection(musicName: musicName, musicIndex: musicIndex);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$musicName'),
            Icon((activeMusicIndex == musicIndex)? Icons.pause : Icons.play_arrow , size: 20)
          ],

        ),
      ),
    );
  }

  void musicSelection({required String musicName, required int musicIndex}){
    if(activeMusicIndex == musicIndex){
      if(isMusicPlaying == true){
        print('got here 1');
        pauseBgSound();
        setState(() {
          activeMusicIndex = 0;
          isMusicPlaying = false;
        });
      }else{
        print('got here 2');
        setState(() {
          activeMusicIndex = musicIndex;
          isMusicPlaying = true;
        });
        playPauseBgSound();
      }
    }else{
      print('got here 3');
      String? uri = MusicLibrary().getMusicUri(musicIndex: musicIndex);
      print('THE MUSIC URL : $uri');
      playBgSound(musicUri: uri!);
      setState(() {
        activeMusicIndex = musicIndex;
        isMusicPlaying = true;
      });

    }
  }


  /// AUDIO FUNCTIONS
  void disposeAudio() async{
    try {
      if(player!=null)
      {
        player.dispose();
      }
      if (assetsAudioPlayer != null) {
        assetsAudioPlayer.stop();
        assetsAudioPlayer.dispose();
      }
    } catch (e) {
      print(e);
    }
  }

  playBgSound({required String musicUri}) async {
    try {
      if (assetsAudioPlayer != null &&
          assetsAudioPlayer.isPlaying.value) {
        assetsAudioPlayer.stop();
      }
    } catch (e) {
      print(e);
    }
    assetsAudioPlayer = AssetsAudioPlayer.withId("1");
    //assetsAudioPlayer.open(Audio.network(isSkip),
    assetsAudioPlayer.open(Audio.network(musicUri),
        autoStart: b,
        loopMode: LoopMode.playlist,
        playInBackground: PlayInBackground.disabledPause,
        audioFocusStrategy: AssetsAudioPlayer.defaultFocusStrategy);
  }

  playPauseBgSound() async {
    try {
      if (assetsAudioPlayer != null) {
        assetsAudioPlayer.playOrPause();
      }
    } catch (e) {
      print('This is an audio errrrrrrrrrrror: $e');
    }
  }

  pauseBgSound() async {
    try {
      if (assetsAudioPlayer != null &&
          assetsAudioPlayer.isPlaying.value) {
        assetsAudioPlayer.stop();
      }
    } catch (e) {
      print('This is an audio errrrrrrrrrrror: $e');
    }
  }


}