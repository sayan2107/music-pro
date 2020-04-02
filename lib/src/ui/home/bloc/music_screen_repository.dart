import 'package:dio/dio.dart';
import 'package:pro_music/src/base/base_repository.dart';
import 'package:pro_music/src/data/model/home/music_data/music_model.dart';
import 'package:pro_music/src/data/model/parsed_response.dart';
import 'package:pro_music/src/data/web_services.dart';
import 'package:pro_music/src/utility/url_constants.dart';

class MusicRepository extends BaseRepository {
  WebServices _webServices;

  MusicRepository(this._webServices);

  Future<ParsedResponse<MusicDataResponse>> fetchMusicData() async {
    try {
      Response response = await _webServices.doGetApiCall(UrlConstants.music_data);
      if(response != null && response.statusCode == BaseRepository.HTTP_OK) {
        return ParsedResponse.addData(MusicDataResponse.fromJson(response.data));
      } else {
        return Future.value(ParsedResponse.addError(handleHttpErrorResponse(response)));
      }
    } on DioError catch(e) {
      return Future.value(ParsedResponse.addError(handleDioError(e)));
    }
  }

}