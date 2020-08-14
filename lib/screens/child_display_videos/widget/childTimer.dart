import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/bloc/child_video_list_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/util/style.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ChildTimer extends StatelessWidget {
  final Function updateTimer;
  final Timer timer;
  ChildTimer(this.timer, this.updateTimer);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Countdown(
            controller: Provider.of<TimerData>(context).controller,
            seconds: timer.remainSec.toInt(),
            build: (_, double time) {
              updateTimer(
                Timer(
                    remainSec: time.toInt(),
                    lableText: timer.lableText,
                    lengthSec: timer.lengthSec,
                    isComplete: timer.isComplete),
              );
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
                  percent: time / timer.lengthSec.toDouble(),
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
            onFinished: () {
              // SystemNavigator.pop();
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
