import 'package:flutter/material.dart';
import '../models/episode.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class EpisodeProvider with ChangeNotifier {
  final List<Episode> _episodeData = [];
  List<Episode> get episodeItem {
    return [..._episodeData];
  }

  Future<void> uploadEpisodesToFirebaseStorage(
      Episode episodesData,DateTime date,String link, File video) async {
    try {
     const url =
          'https://genos-c2a9f-default-rtdb.firebaseio.com/The Family Man/Episodes.json';
      await http.post(url,
          body: json.encode({
            'Episode Name': episodesData.episodeName,
            'Episode Description': episodesData.episodeDescription,
            'Episode Release Date': date.toIso8601String(),
            'Episode link': link
          }));
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
