import 'package:flutter/material.dart';
import './screens/seriesscreen.dart';
import './screens/seriesposterscreen.dart';
import 'package:provider/provider.dart';
import './providers/seriesProvider.dart';
import './screens/previewscreen.dart';
import './providers/episodeProvider.dart';
import './screens/uploadepisodescreen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: SeriesProvider()),
          ChangeNotifierProvider.value(value: EpisodeProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              SeriesPosterScreen.routeName: (ctx) => SeriesPosterScreen(),
              PreviewScreen.routeName: (ctx) => PreviewScreen(),
              UploadEpisodeScreen.routeName: (ctx) => UploadEpisodeScreen()
            },
            home: SeriesScreen()));
  }
}
