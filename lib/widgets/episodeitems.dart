import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/episodevideoscreen.dart';

class EpisodeItems extends StatelessWidget {
  final String id;
  final String episodeName;
  final String episodeDescription;
  final String episodeVideo;
  final DateTime date;
  EpisodeItems(
      {@required this.id,
      @required this.episodeName,
      @required this.episodeDescription,
      @required this.episodeVideo,
      @required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(40)),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 300,
              child: Text(
                episodeDescription,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                child: Chip(
                    label: Text(
                  DateFormat.yMMMEd().format(date),
                  style: TextStyle(color: Colors.black),
                ))),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  episodeName,
                  style: TextStyle(color: Colors.black),
                )),
            Positioned(
              bottom: 10,
              right: 70,
              child:
               Container(
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          EpisodeVideoScreen.routeName,
                          arguments: {
                            'id': id,
                            'episodeName': episodeName,
                            'video': episodeVideo
                          });
                    },
                    child: Text(
                      'Watch Now',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )),
            ),
          ],
        ));
  }
}
