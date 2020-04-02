import 'package:pro_music/src/ui/home/screens/music_lists_screen.dart';
import 'package:pro_music/src/utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pro_music/src/routes.dart';
import 'package:pro_music/generated/i18n.dart';

class ProMusicApp extends StatefulWidget {
  static const locale = [Locale("en", "")];

  static void setLocale(BuildContext context, Locale newLocale) async {
    _ProMusicAppState state =
        context.ancestorStateOfType(TypeMatcher<_ProMusicAppState>());

    state.setState(() {
      state.locale = newLocale;
    });
  }

  @override
  _ProMusicAppState createState() => _ProMusicAppState();
}

class _ProMusicAppState extends State<ProMusicApp> {
  var locale = ProMusicApp.locale[0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: Colors.black,
          primaryColorDark: ColorConstants.input_bg_color_dark,
          accentColor: Colors.grey,
          fontFamily: 'Poppins'),
      localizationsDelegates: [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: S.delegate.resolution(fallback: locale),
      home: MusicListsScreen(),
      onGenerateRoute: (RouteSettings settings) {
        return Routes.onGenerateRoute(settings);
      },
    );
  }
}
