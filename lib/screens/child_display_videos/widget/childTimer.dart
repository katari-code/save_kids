import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:save_kids/models/timer.dart';

import 'package:save_kids/screens/create_child_profile/create_child_profile.dart';
import 'package:save_kids/util/preference/prefs_singleton.dart';
import 'package:save_kids/util/style.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ChildTimer extends StatefulWidget {
  // final Function updateTimer;
  // final Timer timer;
  final childId;
  ChildTimer({this.childId});
  @override
  _ChildTimerState createState() => _ChildTimerState();
}

class _ChildTimerState extends State<ChildTimer> {
  final CountdownController controller = CountdownController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerString = PreferenceUtils.getString(widget.childId + "_timer");
    final timer = Timer.fromJson(jsonDecode(timerString));
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Countdown(
            controller: controller,
            seconds: timer.remainSec,
            build: (_, double time) {
              // updateTimer(
              //   Timer(
              //     remainSec: time.toInt(),
              //     lableText: timer.lableText,
              //     lengthSec: timer.lengthSec,
              //     isComplete: timer.isComplete,
              //   ),
              // );
              // print(timer.lengthSec);
              timer.remainSec = time.toInt();
              PreferenceUtils.setString(
                  widget.childId + "_timer", jsonEncode(timer));
              return Container(
                width: MediaQuery.of(context).size.width * 0.16,
                padding: EdgeInsets.only(top: 7),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/clock.png"),
                  ),
                ),
                child: CircularPercentIndicator(
                  radius: 70.0,
                  animation: false,
                  animationDuration: 1200,
                  lineWidth: 40.0,
                  percent: time / timer.lengthSec,
                  center: CircleAvatar(
                    backgroundColor: Color(0xff51197C),
                    radius: 25,
                    child: Text(
                      displayTime(time),
                      textAlign: TextAlign.center,
                      style: kBubblegum_sans16.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: Colors.transparent,
                  progressColor: kYellowColor,
                ),
              );
            },
            interval: Duration(milliseconds: 100),
            onFinished: () async {
              await buildShowModeDialog(context);
              SystemNavigator.pop();
            },
          )),
    );
  }

  String displayTime(double time) {
    if (time / 3600.0 > 1) {
      return "${(time / 3600.0).floor()} hour";
    } else if (time / 60 > 1) {
      return "${(time / 60.0).floor()} mins";
    } else if (time <= 0) {
      return "Times Up";
    } else {
      return "1 min";
    }
  }
}

Future buildShowModeDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext _) => StatefulBuilder(
      builder: (context, setStaste) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: 300,
          decoration: BoxDecoration(
            color: kRedColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Time's Up",
                    textAlign: TextAlign.center,
                    style: kBubblegum_sans32.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, null),
                    child: AgeChip(
                      color: kBlueDarkColor,
                      text: "See you tomorrow",
                      highet: 60.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
