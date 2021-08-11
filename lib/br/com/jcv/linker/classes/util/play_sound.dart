//import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaySound {

  String soundPath;
  final player = AudioCache();

  PlaySound(this.soundPath);

  void play()
  {
    player.play(soundPath);
  }

  
}