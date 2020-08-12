import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart' as provider;
import 'package:save_kids/bloc/watch_schedule_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/models/schedule_data.dart';
import 'package:save_kids/screens/create_child_profile/create_child_profile.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/avatart_carousel.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/schedule_card.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/top_schedule.dart';
import 'package:save_kids/util/style.dart';

import '../add_schedule.dart';

class WatchSchedule extends StatefulWidget {
  @override
  _WatchScheduleState createState() => _WatchScheduleState();
}

class _WatchScheduleState extends State<WatchSchedule> {
  bool isInit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurpleColor,
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Consumer<WatchScheduleBloc>(
                builder: (context, watchScheduleBloc) => SafeArea(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: kYellowColor,
                            padding: EdgeInsets.all(15),
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Watch Schedule",
                                      style: kBubblegum_sans28.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SvgPicture.asset('images/svgs/schedule.svg')
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Column(
                            children: <Widget>[
                              StreamBuilder<List<Child>>(
                                  stream: watchScheduleBloc.children.stream,
                                  initialData: null,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (isInit && snapshot.data.length > 0) {
                                        watchScheduleBloc.changeChosenChild(
                                            snapshot.data[0].id);
                                        isInit = false;
                                      }
                                      if (snapshot.data.length > 0) {
                                        return AvatrsCarousel(snapshot.data,
                                            (String id) {
                                          watchScheduleBloc
                                              .changeChosenChild(id);
                                        });
                                      }
                                      return Center(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            'No children To Display',
                                            style: kBubblegum_sans32.copyWith(
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }
                                    return ProgressBar(
                                      color: Colors.white,
                                    );
                                  }),
                              TopCalendar(watchScheduleBloc.changeChosenDate),
                              StreamBuilder<List<Schedule>>(
                                stream: watchScheduleBloc.schedules.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Schedule> schedules =
                                        snapshot.data ?? [];
                                    return Column(
                                      children: List.generate(
                                        schedules.length,
                                        (index) => ScheduleCard(
                                            schedule: schedules[index],
                                            deleteSchedule: watchScheduleBloc
                                                .deleteSchedule),
                                      ),
                                    );
                                  }
                                  return ProgressBar(
                                    color: Colors.white,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              StreamBuilder<String>(
                                  stream: watchScheduleBloc.chosenChild.stream,
                                  builder: (context, child) {
                                    if (child.hasData) {
                                      String chosenChild = child.data;
                                      return StreamBuilder<DateTime>(
                                          stream: watchScheduleBloc
                                              .chosenDate.stream,
                                          builder: (context, date) {
                                            DateTime dateTime = date.data;
                                            if (chosenChild != null &&
                                                dateTime != null &&
                                                dateTime.isAfter(DateTime.now()
                                                    .subtract(Duration(
                                                        hours: DateTime.now()
                                                            .hour)))) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  //check if there is a child
                                                  //dateime is not empy
                                                  //datetime chosen is after current time

                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddSchedule(
                                                              child.data,
                                                              dateTime),
                                                    ),
                                                  );
                                                },
                                                child: AgeChip(
                                                  highet: 60.0,
                                                  width: 220.0,
                                                  text: "Add to Schedule",
                                                  color: kBlueDarkColor,
                                                ),
                                              );
                                            }
                                            return Text('');
                                          });
                                    }
                                    return ProgressBar(
                                      color: Colors.white,
                                    );
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
