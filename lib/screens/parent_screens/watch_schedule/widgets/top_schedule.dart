import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/schedule_data.dart';
import 'package:save_kids/util/style.dart';
import 'package:table_calendar/table_calendar.dart';

class TopCalendar extends StatefulWidget {
  @override
  _TopCalendarState createState() => _TopCalendarState();
}

class _TopCalendarState extends State<TopCalendar>
    with TickerProviderStateMixin {
  CalendarController controller;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller = CalendarController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: <Widget>[
          TableCalendar(
            availableGestures: AvailableGestures.all,
            formatAnimation: FormatAnimation.slide,
            initialCalendarFormat: CalendarFormat.week,
            calendarController: controller,
            startingDayOfWeek: StartingDayOfWeek.monday,
            weekendDays: [DateTime.friday, DateTime.saturday],
            //body
            calendarStyle: CalendarStyle(
              selectedColor: Colors.white,
              selectedStyle: TextStyle(color: Colors.black, fontSize: 18),
              todayColor: Colors.white.withOpacity(0.5),
              markersColor: Colors.brown[700],
              outsideDaysVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: kBubblegum_sans20.copyWith(color: Colors.white),
              weekdayStyle: kBubblegum_sans20.copyWith(color: Colors.white),
            ),
            //Header
            headerStyle: HeaderStyle(
              formatButtonShowsNext: true,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 30,
              ),
              formatButtonTextStyle:
                  TextStyle().copyWith(color: Colors.brown, fontSize: 20.0),
              titleTextStyle: kBubblegum_sans28.copyWith(color: Colors.white),
              formatButtonDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            rowHeight: 65,
            builders: CalendarBuilders(
                // The current Day that is not changeble (Your computer Date)
                todayDayBuilder: (context, date, event) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: Text(
                        '${date.day} ',
                        style: kBubblegum_sans20.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            },
                // The Selected day by the user
                selectedDayBuilder: (context, date, _) {
              return FadeTransition(
                opacity:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2),
                        width: 50,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kRedColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style:
                                kBubblegum_sans20.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, dayBuilder: (contex, date, event) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Spacer(flex: 1,),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      '${date.day}',
                      style: kBubblegum_sans20.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            }),
            onDaySelected: (date, meeting) {
              Provider.of<ScheduleData>(context, listen: false)
                  .setcurrentDate(date);

              _animationController.forward(from: 0.0);
            },
            availableCalendarFormats: const {
              CalendarFormat.week: 'Week',
            },
          ),
        ],
      ),
    );
  }
}
