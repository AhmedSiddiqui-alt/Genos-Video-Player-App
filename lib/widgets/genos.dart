import 'package:flutter/material.dart';

class Genos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
            child: ClipOval(
                child: Image.asset('assets/images/G.jpg',
                    height: 140,width:150, fit: BoxFit.cover)));
  }
}
