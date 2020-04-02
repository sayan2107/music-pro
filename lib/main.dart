import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_music/src/data/shared_pref.dart';
import 'package:pro_music/src/data/web_services.dart';
import 'package:pro_music/src/infra/network/web_services_impl.dart';
import 'package:pro_music/src/infra/sharedpreference_helper.dart';
import 'package:pro_music/src/pro_music_app.dart';
import 'package:pro_music/src/utility/url_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpDependencyInjection();

  runApp(ProMusicApp());
}

void setUpDependencyInjection() {
  GetIt.instance.registerLazySingleton<SharedPrefData>(() => SharedPrefsImpl());
  GetIt.instance.registerLazySingleton<WebServices>(() => WebServicesImpl(UrlConstants.BASE_URL));
}
