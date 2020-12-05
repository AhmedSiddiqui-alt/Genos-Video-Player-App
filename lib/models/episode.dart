import 'package:flutter/foundation.dart';
import 'dart:io';

class Episode {
  final String episodeId;
  final File episodes;
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
