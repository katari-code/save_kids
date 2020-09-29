import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:save_kids/models/timer.dart';

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
          StreamBuilder<Timer>(
              initialData: childBloc.timers[0],
              stream: childBloc.timer,
              builder: (context, snapshot) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 4),
                  ),
                  child: DropdownButton<Timer>(
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    hint: Text("Select item"),
                    value: snapshot.data ?? timers[0],
                    focusColor: Colors.white,
                    onChanged: (Timer timer) {
                      childBloc.changeTimer(timer);
                    },
                    items: timers.map((Timer timer) {
                      return DropdownMenuItem<Timer>(
                        value: timer,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Icon(
                            //   Icons.lock_clock,
                            //   color: Colors.white,
                            // ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              timer.lableText,
                              style: kBubblegum_sans24.copyWith(
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              })
        ],
      ),
    );
  }
}
