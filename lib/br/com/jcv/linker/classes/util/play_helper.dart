import 'package:junta192/br/com/jcv/linker/classes/util/play_sound.dart';

class PlayHelper {

  static void play(String sound){
    PlaySound ps = new PlaySound(sound);
    ps.play();
  }
}