import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/bloc/child_video_list_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/screens/create_child_profile/create_child_profile.dart';
import 'package:save_kids/util/style.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ChildTimer extends StatelessWidget {
  final Function updateTimer;
  final Timer timer;
  final bloc;
  final String childId;
  ChildTimer(this.timer, this.updateTimer, this.bloc, this.childId);
  final CountdownController controller = CountdownController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Countdown(
            controller: controller,
            seconds: timer.remainSec.toInt(),
            build: (_, double time) {
              updateTimer(
                Timer(
                  remainSec: time.toInt(),
                  lableText: timer.lableText,
                  lengthSec: timer.lengthSec,
                  isComplete: timer.isComplete,
                ),
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
            onFinished: () async {
              await buildShowModeDialog(context);
              bloc.updateTimer(
                Timer(
                  remainSec: 0,
                  lableText: timer.lableText,
                  lengthSec: timer.lengthSec,
                  isComplete: true,
                ),
              );
              await bloc.storeTimer(childId);
              SystemNavigator.pop();
            },
          )),
    );
  }

  String displayTime(double time) {
    if (time / 3600.0 > 1) {
      return "${(time / 3600.0).floor()} :${((time % 3600.0) / 60).floor()}   hour";
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
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: 300,
          decoration: BoxDecoration(
            color: kRedColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: 300,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    'images/svgs/timespopup.svg',
                    height: 120,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "your time is up for today",
                    textAlign: TextAlign.center,
                    style: kBubblegum_sans32.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, null),
                      child: AgeChip(
                        color: kBlueDarkColor,
                        text: "See you tomorrow",
                        highet: 60.0,
                      ),
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

Future buildShowModeDialog1(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext _) => StatefulBuilder(
      builder: (context, setStaste) => Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: 300,
          decoration: BoxDecoration(
            color: kBlueDarkColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: 300,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    'images/svgs/girls_popup.svg',
                    height: 145,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Ask your parents first",
                    textAlign: TextAlign.center,
                    style: kBubblegum_sans32.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, null),
                      child: AgeChip(
                        color: kRedColor,
                        text: "See you again",
                        highet: 60.0,
                      ),
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

Future buildShowModeDialog2(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext _) => StatefulBuilder(
      builder: (context, setStaste) => Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: 300,
          decoration: BoxDecoration(
            color: kBlueDarkColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: 300,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 280,
                    child: Image.asset(
                      "images/parentPopup.gif",
                      width: 180,
                      height: 280,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Add videos you choose for your kids",
                    textAlign: TextAlign.center,
                    style: kBubblegum_sans32.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, null),
                      child: AgeChip(
                        color: kRedColor,
                        text: "Okay",
                        highet: 60.0,
                      ),
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

Future buildShowModeDialog3(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext _) => StatefulBuilder(
      builder: (context, setStaste) => Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: 300,
          decoration: BoxDecoration(
            color: kBlueDarkColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: 300,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 280,
                    child: Image.asset(
                      "images/PopUpAfterPayment.gif",
                      width: 180,
                      height: 280,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Now, you can change your account mode",
                    textAlign: TextAlign.center,
                    style: kBubblegum_sans32.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, null),
                      child: AgeChip(
                        color: kRedColor,
                        text: "Okay",
                        highet: 60.0,
                      ),
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
