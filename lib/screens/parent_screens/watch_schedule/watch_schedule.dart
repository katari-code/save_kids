import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart' as provider;
import 'package:save_kids/bloc/watch_schedule_bloc.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/models/schedule_data.dart';
import 'package:save_kids/screens/child_screen/create_child_profile.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/avatart_carousel.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/schedule_card.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/top_schedule.dart';
import 'package:save_kids/util/style.dart';

import '../add_schedule.dart';

class WatchSchedule extends StatelessWidget {
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
              builder: (context, watchScheduleBloc) =>
                  provider.Consumer<ScheduleData>(
                builder: (context, scheduleData, child) {
                  var showTime = scheduleData.getChildShowTime();
                  return SafeArea(
                    child: StreamBuilder<Parent>(
                        stream: watchScheduleBloc.parentSession,
                        builder: (context, snapshot) {
                          Parent parent = snapshot.data;
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  color: kYellowColor,
                                  padding: EdgeInsets.all(15),
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                          SvgPicture.asset(
                                              'images/svgs/schedule.svg')
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
                                    StreamBuilder<Object>(
                                        stream: watchScheduleBloc
                                            .children(parent.id),
                                        initialData: null,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return AvatrsCarousel(
                                                snapshot.data,
                                                watchScheduleBloc
                                                    .changeChosenChild);
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    TopCalendar(
                                        watchScheduleBloc.changeChosenDate),
                                    StreamBuilder<List<Schedule>>(
                                        stream: watchScheduleBloc.getSchedule(),
                                        builder: (context, snapshot) {
                                          List<Schedule> schedules =
                                              snapshot.data ?? [];
                                          // Logger().i(schedules.length);
                                          return Column(
                                            children: List.generate(
                                              schedules.length,
                                              (index) => ScheduleCard(
                                                showTimeCard: showTime[index],
                                                schedule: schedules[index],
                                              ),
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    StreamBuilder<Object>(
                                        stream: watchScheduleBloc.chosenChild,
                                        builder: (context, snapshot) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddSchedule(
                                                          snapshot.data),
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
                                        }),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                )
                              ],
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Consumer<Calenders>(
//   builder: (context, schedule, child) => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: <Widget>[
//       ...List<GestureDetector>.generate(
//         Calenders.days.length,
//         (index) => GestureDetector(
//           onTap: () => schedule.setcurrentDate(index),
//           child: Container(
//             padding: EdgeInsets.all(2),
//             width: 50,
//             height: 40,
//             decoration: BoxDecoration(
//               color: schedule.currentDate == index
//                   ? kRedColor
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Text(
//                 Calenders.days[index],
//                 style: kBubblegum_sans20.copyWith(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       )
//     ],
//   ),
// ),
