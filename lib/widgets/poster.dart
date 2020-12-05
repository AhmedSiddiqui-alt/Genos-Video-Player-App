import 'package:flutter/material.dart';
import '../screens/previewscreen.dart';

class Poster extends StatelessWidget {
  final String seriesId;
  final String imagePath;
  Poster({@required this.seriesId, @required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            )),
        Positioned(
          bottom: 70,
          right: 120,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(PreviewScreen.routeName, arguments: seriesId);
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.play_arrow),
                  Text(
                    'Preview',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
