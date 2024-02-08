class MusicLibrary{
  String song1 = "https://easyfeed.s3.us-east-2.amazonaws.com/Rock_a_bye_Baby.mp3";
  String song2 = "https://easyfeed.s3.us-east-2.amazonaws.com/Twinkle_Twinkle_Little_Star.mp3";
  String song3 = "https://easyfeed.s3.us-east-2.amazonaws.com/amazing_race.mp3";
  String song4 = "https://easyfeed.s3.us-east-2.amazonaws.com/GoodnightSweetheart+Goodnight.mp3";
  String song5 = "https://easyfeed.s3.us-east-2.amazonaws.com/Brahms-Lullaby_x264.mp4";
  String song6 = "https://easyfeed.s3.us-east-2.amazonaws.com/Are_You_Sleeping.mp3";
  String song7 = "https://easyfeed.s3.us-east-2.amazonaws.com/Swing_Low_Sweet_Chariot.mp3";
  String song8 = "https://easyfeed.s3.us-east-2.amazonaws.com/Star_Light_Star_Bright+_+Kids+Songs.mp3";
  String song9 = "https://easyfeed.s3.us-east-2.amazonaws.com/somewhere_over_the_rainbow.mp4";
  String song10 = "https://easyfeed.s3.us-east-2.amazonaws.com/all_he_pretty_little_Horses.mp3";
  String song11 = "https://easyfeed.s3.us-east-2.amazonaws.com/YOU_ARE_MY_SUNSHINE.mp3";
  String song12 = "https://easyfeed.s3.us-east-2.amazonaws.com/all_he_pretty_little_Horses.mp3";
  String song13 = "https://easyfeed.s3.us-east-2.amazonaws.com/Row_Row_Row_Your_Boat.mp4";
  String song14 = "https://easyfeed.s3.us-east-2.amazonaws.com/Isnt-She-Lovely.mp3";
  String song15 = "https://easyfeed.s3.us-east-2.amazonaws.com/Beautiful_boy.mp3";


  String? getMusicUri({required int musicIndex}){
    switch(musicIndex){
      case 1:
        return song1;
      case 2:
        return song2;
      case 3:
        return song3;
      case 4:
        return song4;
      case 5:
        return song5;
      case 6:
        return song6;
      case 7:
        return song7;
      case 8:
        return song8;
      case 9:
        return song9;
      case 10:
        return song10;
      case 11:
        return song11;
      case 12:
        return song12;
      case 13:
        return song13;
      case 14:
        return song14;
      case 15:
        return song15;
    }
  }
}