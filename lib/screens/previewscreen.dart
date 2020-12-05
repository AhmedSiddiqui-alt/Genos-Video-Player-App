import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../providers/seriesProvider.dart';
import '../widgets/poster.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatefulWidget {
  static const routeName = '/previewScreen';

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController videoplayercontroller;
  @override
  void didChangeDependencies() {
    final catchId = ModalRoute.of(context).settings.arguments as String;
    final seriesItems = Provider.of<SeriesProvider>(context)
        .seriesData
        .firstWhere((seriesData) {
      return seriesData.seriesId == catchId;
    });
    videoplayercontroller =
        VideoPlayerController.asset(seriesItems.seriesTrailer);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    videoplayercontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Prview',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: 
      Container(
        margin: EdgeInsets.all(10),
        child: Chewie(
          controller: ChewieController(
              allowFullScreen: true,
              looping: true,
              videoPlayerController: (videoplayercontroller),
              autoInitialize: true,
              autoPlay: true,
              aspectRatio: 16 / 9),
        ),
      ),
    );
  }
}
