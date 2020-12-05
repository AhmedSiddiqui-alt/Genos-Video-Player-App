import 'package:flutter/material.dart';

class Casts extends StatelessWidget {
  final String castImagePath;
  Casts({@required this.castImagePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ClipOval(
        child: Image.asset(
          castImagePath,
          height: 100,
          width: 110,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
