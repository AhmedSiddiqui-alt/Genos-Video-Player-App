import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/episodeProvider.dart';
import '../widgets/episodeitems.dart';
import './seriesposterscreen.dart';

class EpisodeScreen extends StatefulWidget {
  static const routeName = '/episodeScreen';
  @override
  _EpisodeScreenState createState() => _EpisodeScreenState();
}

bool isLoading = true;
bool init = true;

class _EpisodeScreenState extends State<EpisodeScreen> {
  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<EpisodeProvider>(context).fetchDataFromFirebase().then((_) {
        setState(() {
          isLoading = false;
        });
      }).catchError((_) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content:
                    Text('Some Sort of Distortion Has Occured From Server'),
                actions: <Widget>[
                  Container(
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40)),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(ctx).pushReplacementNamed(SeriesPosterScreen.routeName);
                        },
                        child: Text(
                          'Okay',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      )),
                ],
              );
            });
      });

      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final episodeData = Provider.of<EpisodeProvider>(context).episodeItem;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SeriesPosterScreen.routeName);
                })
          ],
          backgroundColor: Colors.black,
          title: Text(
            'Episodes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      height: 600,
                      child: Card(
                        color: Colors.black,
                        elevation: 6,
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return EpisodeItems(
                                id: episodeData[index].episodeId,
                                episodeName: episodeData[index].episodeName,
                                episodeDescription:
                                    episodeData[index].episodeDescription,
                                episodeVideo: episodeData[index].episodes,
                                date: episodeData[index].date);
                          },
                          itemCount: episodeData.length,
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
