import 'package:flutter/foundation.dart';

class Episode {
  final String episodeId;
  final dynamic episodes;
  final String episodeName;
  final String episodeDescription;
  final DateTime date;
  Episode(
      {@required this.episodeId,
      @required this.episodeName,
      @required this.episodes,
      @required this.episodeDescription,
      @required this.date});
}
