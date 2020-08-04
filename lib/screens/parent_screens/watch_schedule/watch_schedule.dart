import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
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
            child: Consumer<ScheduleData>(
              builder: (context, scheduleData, child) {
                var showTime = scheduleData.getChildShowTime();
                return Column(
                  children: <Widget>[
                    Container(
                      color: kYellowColor,
                      padding: EdgeInsets.all(15),
                      height: 110,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Watch Schedule",
                                style: kBubblegum_sans28.copyWith(
                                  color: Colors.white,
                                ),
                              ),
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
                        AvatrsCarousel(),
                        TopCalendar(),
                        Column(
                          children: List.generate(
                            showTime.length,
                            (index) => ScheduleCard(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSchedule(),
                              ),
                            );
                          },
                          child: AgeChip(
                            highet: 60.0,
                            width: 220.0,
                            text: "Add to Schedule",
                            color: kBlueDarkColor,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  ],
                );
              },
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
