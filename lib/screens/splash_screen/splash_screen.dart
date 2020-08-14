import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/util/constant.dart';

class SpalschScreen extends StatefulWidget {
  @override
  _SpalschScreenState createState() => _SpalschScreenState();
}

class _SpalschScreenState extends State<SpalschScreen> {
  final bloc = BlocProvider.getBloc<AuthBloc>();
  Future getUser() async {
    final result = await bloc.parentSession.first;
    if (result != null) {
      Navigator.pushReplacementNamed(context, kChildAccountRoute);
    } else
      Navigator.pushReplacementNamed(context, kSignInRoute);
  }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => getUser(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // child: Image.asset(
        //   "images/sc.png",
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
