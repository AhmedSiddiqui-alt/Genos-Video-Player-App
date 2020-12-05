import 'package:Genos/providers/seriesProvider.dart';
import 'package:flutter/material.dart';
import '../widgets/genos.dart';
import '../screens/seriesposterscreen.dart';
import '../screens/uploadepisodescreen.dart';

class SeriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(UploadEpisodeScreen.routeName);
                })
          ],
          backgroundColor: Colors.black54,
          title: Text(
            'Genos Player',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 140),
              alignment: Alignment.center,
              child: Genos()),
          Container(
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SeriesPosterScreen.routeName);
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.play_arrow),
                    Text(
                      'Next',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )),
          )
        ])));
  }
}
