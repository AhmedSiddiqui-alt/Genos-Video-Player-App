import 'package:Genos/screens/episodescreen.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../screens/episodescreen.dart';

class EpisodeVideoScreen extends StatefulWidget {
  static const routeName = '/episodeVideoScreen';
  @override
  _EpisodeVideoScreenState createState() => _EpisodeVideoScreenState();
}

bool isLoading = true;

class _EpisodeVideoScreenState extends State<EpisodeVideoScreen> {
  VideoPlayerController videoPlayerController;
  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      final episodeId =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      print(episodeId);
      // final episodeData =
      //     Provider.of<EpisodeProvider>(context).episodeItem.firstWhere((data) {
      //   return episodeId['id'] == data.episodeId;
      // });
      // print(episodeData);

      videoPlayerController = VideoPlayerController.network(episodeId['video']);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final episodeName =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(EpisodeScreen.routeName);
              })
        ],
        backgroundColor: Colors.black,
        title: Text(
          episodeName['episodeName'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Chewie(
          controller: ChewieController(
              allowFullScreen: true,
              looping: true,
              videoPlayerController: (videoPlayerController),
              autoInitialize: true,
              autoPlay: true,
              errorBuilder: (context, errorMessage) {
                return Center(
                    child: Container(
                        child: Text(
                  'Check Your Internet Connection',
                  style: TextStyle(color: Colors.white),
                )));
              },
              aspectRatio: 16 / 9),
        ),
      ),
    );
  }
}
