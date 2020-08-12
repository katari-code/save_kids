import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

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
    // Timer(
    //   Duration(seconds: 1),
    //   () => getUser(),
    // );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: kBubblegum_sans44,
        ),
      ),
    );
  }
}
