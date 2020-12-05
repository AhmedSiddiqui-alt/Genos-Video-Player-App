import 'package:flutter/foundation.dart';

class Series {
  final String seriesId;
  final String seriesTitle;
  final String seriesPoster;
  final String seriesTrailer;
  final List seriesCast;
  final String seriesDescription;
  Series(
      {@required this.seriesId,
      @required this.seriesTitle,
      @required this.seriesPoster,
      @required this.seriesTrailer,
      @required this.seriesCast,
      @required this.seriesDescription});
}
