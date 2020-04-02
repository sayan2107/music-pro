import 'package:pro_music/src/base/ui_event.dart';
import 'package:pro_music/src/data/model/home/music_data/music_model.dart';
class NavigateToMusicDetails extends UIEvent {
  Results results;
  NavigateToMusicDetails(this.results) : super(null);
}