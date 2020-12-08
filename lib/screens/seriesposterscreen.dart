import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/seriesProvider.dart';
import '../widgets/poster.dart';
import '../widgets/casts.dart';
import '../screens/episodescreen.dart';

class SeriesPosterScreen extends StatefulWidget {
  static const routeName = 'SeriesPosterScreen';

  @override
  _SeriesPosterScreenState createState() => _SeriesPosterScreenState();
}

class _SeriesPosterScreenState extends State<SeriesPosterScreen> {
  bool isLoading = true;
  bool init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      Future.delayed(Duration(seconds: 4)).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    init = false;
  }

  Widget build(BuildContext context) {
    final seriesItems = Provider.of<SeriesProvider>(context)
        .seriesData
        .firstWhere((seriesData) {
      return true;
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(EpisodeScreen.routeName);
              })
        ],
        backgroundColor: Colors.black54,
        title: Text(
          'The Family Man',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Poster(
                    seriesId: seriesItems.seriesId,
                    imagePath: seriesItems.seriesPoster,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      seriesItems.seriesDescription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Cast',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Casts(
                            castImagePath: seriesItems.seriesCast[index]
                                ['castImage']);
                      },
                      itemCount: seriesItems.seriesCast.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
