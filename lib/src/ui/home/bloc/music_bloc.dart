import 'package:pro_music/src/data/model/home/music_data/music_model.dart';
import 'package:pro_music/src/data/model/parsed_response.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_music/src/base/ui_event.dart';
import 'package:pro_music/src/data/web_services.dart';
import 'package:pro_music/src/infra/bloc/bloc_provider.dart';
import 'package:pro_music/src/ui/home/bloc/music_screen_events.dart';
import 'package:pro_music/src/ui/home/bloc/music_screen_repository.dart';
import 'package:rxdart/rxdart.dart';

class MusicBloc extends BaseBloc {

  MusicRepository _musicRepository;

  MusicBloc() {
    _musicRepository = MusicRepository(GetIt.I<WebServices>());
  }

  BehaviorSubject<UIEvent> _uiEventStreamController = BehaviorSubject();
  Stream<UIEvent> get uiEventStream => _uiEventStreamController.stream;

  BehaviorSubject<MusicDataResponse> _musicStreamController = BehaviorSubject();
  Stream<MusicDataResponse> get musicStream => _musicStreamController.stream;


  void getMusicData() async {
      _uiEventStreamController.add(LoadingScreenUiEvent(true));
      ParsedResponse<MusicDataResponse> profileResponse = await _musicRepository.fetchMusicData();
      _uiEventStreamController.add(LoadingScreenUiEvent(false));
      if(profileResponse.hasData) {
        _musicStreamController.add(profileResponse.data);
      } else {
        _uiEventStreamController.add(SnackBarEvent(profileResponse.error.message));
      }
    }

  void redirectToMusicDetails(Results result) {
    _uiEventStreamController.add(NavigateToMusicDetails(result));
  }



  @override
  void onDispose() {
    _uiEventStreamController.close();
    _musicStreamController.close();
  }

}