import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/util/style.dart';

class TimeCoursal extends StatefulWidget {
  @override
  _TimeCoursalState createState() => _TimeCoursalState();
}

class _TimeCoursalState extends State<TimeCoursal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Consumer<TimerData>(builder: (context, timer, child) {
            var timerData = timer.timers;
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 80,
                viewportFraction: 0.3,
                initialPage: timer.currentTimerindex,
                enableInfiniteScroll: true,
                reverse: true,
                enlargeCenterPage: true,
                onPageChanged: (index, CarouselPageChangedReason reason) {
                  timer.setCurrentTimer(index);
                },
                scrollDirection: Axis.horizontal,
              ),
              itemCount: timerData.length,
              itemBuilder: (BuildContext context, int itemIndex) => Text(
                timerData[itemIndex].lableText,
                style: kCapriola28.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
