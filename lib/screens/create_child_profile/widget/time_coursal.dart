import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:save_kids/util/style.dart';

class TimeCoursal extends StatelessWidget {
  final childBloc;
  TimeCoursal({this.childBloc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          StreamBuilder<Object>(
              initialData: childBloc.timers[0],
              stream: childBloc.timer,
              builder: (context, snapshot) {
                return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 80,
                    viewportFraction: 0.5,
                    enableInfiniteScroll: true,
                    reverse: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, CarouselPageChangedReason reason) {
                      childBloc.changeTimer(childBloc.timers[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: childBloc.timers.length,
                  itemBuilder: (BuildContext context, int itemIndex) => Text(
                    childBloc.timers[itemIndex].lableText,
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
