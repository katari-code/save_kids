import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressBar extends StatelessWidget {
  final Color color;
  ProgressBar({this.color});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 10),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Container(
                child: Center(
              child: SpinKitFadingCube(
                color: color ?? Colors.blueAccent,
                size: 30.0,
              ),
            ));
          }
          return Center(
            child: Text('Something went Wrong :('),
          );
        });
  }
}
