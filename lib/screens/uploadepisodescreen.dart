import 'package:flutter/material.dart';
import '../models/episode.dart';
import 'package:intl/intl.dart';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import '../providers/episodeProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadEpisodeScreen extends StatefulWidget {
  @override
  static const routeName = '/uploadVideoScreen';
  _UploadEpisodeScreenState createState() => _UploadEpisodeScreenState();
}

class _UploadEpisodeScreenState extends State<UploadEpisodeScreen> {
  DateTime date;
  File videoPicker;
  bool isLoading = false;
  VideoPlayerController videoplayercontroller;
  @override
  void dispose() {
    videoplayercontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  var manageEpisode = Episode(
      episodeId: null,
      episodeName: null,
      episodes: null,
      episodeDescription: null,
      date: null);
  final formKey = GlobalKey<FormState>();
  Future<void> fetchVideoFromGallery() async {
    final video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      videoPicker = video;
      videoplayercontroller = VideoPlayerController.file(videoPicker);
    });
  }

  Future<String> saveVideoInStorage() async {
    String link;

    const url =
        'https://genos-c2a9f-default-rtdb.firebaseio.com/The Family Man/Episodes.json';
    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference rootReference = fs.ref();
    StorageReference videoFolderRef = rootReference
        .child('The Family Man Episodes')
        .child(manageEpisode.episodeName);
    await videoFolderRef
        .put(videoPicker, StorageMetadata(contentType: 'Video/mkv'))
        .onComplete
        .then((getVideoURL) async {
      link = await getVideoURL.ref.getDownloadURL();
      print(link);
    });
    return link;
  }

  Future<void> saveForm() async {
    try {
      formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      String link = await saveVideoInStorage();
      await Provider.of<EpisodeProvider>(context)
          .uploadEpisodesToFirebaseStorage(
              manageEpisode, date, link, videoPicker);
      Navigator.of(context).pop();
    } catch (error) {
      String bug = error;
      print(bug);
      showDialog(
          context: (context),
          builder: (ctx) {
            return AlertDialog(
              content: Text(
                bug,
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text(
                        'Okay',
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ],
            );
          });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Upload Episodes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ))
            : Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    videoplayercontroller != null
                        ? Container(
                            height: 300,
                            margin: EdgeInsets.all(10),
                            child: Chewie(
                              controller: ChewieController(
                                  allowFullScreen: false,
                                  looping: true,
                                  videoPlayerController:
                                      (videoplayercontroller),
                                  autoInitialize: true,
                                  autoPlay: false,
                                  aspectRatio: 16 / 9),
                            ))
                        : Container(
                            alignment: Alignment.center,
                            height: 300,
                            child: Text(
                              'No Video Is Loaded From Gallery',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    IconButton(
                        icon: Icon(Icons.camera),
                        color: Colors.white,
                        onPressed: () {
                          fetchVideoFromGallery();
                        }),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Enter Episode Name',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                              labelText: 'Episode Name',
                              labelStyle: TextStyle(color: Colors.white)),
                          onSaved: (value) {
                            manageEpisode = Episode(
                                episodeId: manageEpisode.episodeId,
                                episodeName: value,
                                episodes: manageEpisode.episodes,
                                episodeDescription:
                                    manageEpisode.episodeDescription,
                                date: manageEpisode.date);
                          },
                        )),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          maxLines: 8,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Enter Episode Story In Three Lines',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                              labelText: 'Episode Description',
                              labelStyle: TextStyle(color: Colors.white)),
                          onSaved: (value) {
                            manageEpisode = Episode(
                                episodeId: manageEpisode.episodeId,
                                episodeName: manageEpisode.episodeName,
                                episodes: manageEpisode.episodes,
                                episodeDescription: value,
                                date: manageEpisode.date);
                          },
                        )),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                child: FlatButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2021))
                                        .then((choosenData) {
                                      if (choosenData != null) {
                                        setState(() {
                                          date = choosenData;
                                        });
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Choose Date',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )),
                            Container(
                              child: date == null
                                  ? Text(
                                      'Date Not Choosen',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(DateFormat.yMMMEd().format(date),
                                      style: TextStyle(color: Colors.white)),
                            )
                          ],
                        )),
                    Container(
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: FlatButton(
                          onPressed: () {
                            saveForm();
                          },
                          child: Text(
                            'Upload',
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                  ],
                ))));
  }
}
