import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/bloc/create_child_profile_bloc.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/util/style.dart';

class TimeCoursal extends StatelessWidget {
  CreateChildProfileBloc createChildBloc;
  TimeCoursal({this.createChildBloc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<Object>(
              initialData: createChildBloc.timers[0],
              stream: createChildBloc.timer,
              builder: (context, snapshot) {
                return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 80,
                    viewportFraction: 0.5,
                    enableInfiniteScroll: true,
                    reverse: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, CarouselPageChangedReason reason) {
                      createChildBloc
                          .changeTimer(createChildBloc.timers[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: createChildBloc.timers.length,
                  itemBuilder: (BuildContext context, int itemIndex) => Text(
                    createChildBloc.timers[itemIndex].lableText,
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
