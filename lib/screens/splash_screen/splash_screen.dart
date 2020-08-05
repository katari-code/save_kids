import 'dart:async';

import 'package:flutter/material.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

class SpalschScreen extends StatefulWidget {
  @override
  _SpalschScreenState createState() => _SpalschScreenState();
}

class _SpalschScreenState extends State<SpalschScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Spalsch Screen",
          style: kBubblegum_sans44,
        ),
      ),
    );
  }
}
