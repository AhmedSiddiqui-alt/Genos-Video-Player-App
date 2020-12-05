import 'package:flutter/material.dart';
import '../models/series.dart';

class SeriesProvider with ChangeNotifier {
  List<Series> _series = [
    Series(
        seriesId: 'S1',
        seriesTitle: 'The Family Man',
        seriesTrailer: 'assets/videos/trailer.mp4',
        seriesPoster: 'assets/images/The Family Man/TFM.jpg',
        seriesCast: [
          {
            'castName': 'Manoj Bajpai',
            'castImage': 'assets/images/The Family Man/manoj.jpg'
          },
          {
            'castName': 'Sharib Hashmi',
            'castImage': 'assets/images/The Family Man/sharib.jpg'
          },
          {
            'castName': 'Shreya Dhanwanthary',
            'castImage': 'assets/images/The Family Man/shreya.jpg'
          },
          {
            'castName': 'Zarin Shihab',
            'castImage': 'assets/images/The Family Man/zarin.jpg'
          },
          {
            'castName': 'Priyamani',
            'castImage': 'assets/images/The Family Man/priya.jpg'
          },
          {
            'castName': 'Neeraj Madhav',
            'castImage': 'assets/images/The Family Man/neeraj.jpg'
          },
          {
            'castName': 'Gul Panag',
            'castImage': 'assets/images/The Family Man/gul.jpg'
          },
          {
            'castName': 'Abrar Qazi',
            'castImage': 'assets/images/The Family Man/abrar.jpg'
          },
          {
            'castName': 'Darshan Kumaar',
            'castImage': 'assets/images/The Family Man/darshan.jpg'
          },
          {
            'castName': 'Sharad Kelkar',
            'castImage': 'assets/images/The Family Man/sharad.jpg'
          },
          {
            'castName': 'Sundeep Kishan',
            'castImage': 'assets/images/The Family Man/sundeep.jpg'
          },
          {
            'castName': 'Kishore',
            'castImage': 'assets/images/The Family Man/kishore.jpg'
          },
          {
            'castName': 'Sunny Hinduja',
            'castImage': 'assets/images/The Family Man/sunny.jpg'
          },
          {
            'castName': 'Mir Sarwar',
            'castImage': 'assets/images/The Family Man/mir.jpg'
          },
          {
            'castName': 'Dinesh Prabhakar',
            'castImage': 'assets/images/The Family Man/dinesh.jpg'
          },
          {
            'castName': 'Dalip Tahil',
            'castImage': 'assets/images/The Family Man/dalip.jpg'
          },
          {
            'castName': 'Pawan Chopra',
            'castImage': 'assets/images/The Family Man/pawan.jpg'
          },
        ],
        seriesDescription:
            'The Family Man is an edgy action-drama series, which tells the story of a middle class man who works for a special cell of the National Investigation Agency. While he tries to protect the nation from terrorist, he also has to protect his family from the impact of his secretive, high-pressure, and low paying job')
  ];
  List<Series> get seriesData {
    return [..._series];
  }
}
