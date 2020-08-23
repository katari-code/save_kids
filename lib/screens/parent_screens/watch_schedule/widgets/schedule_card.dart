import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/util/style.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({this.schedule, this.deleteSchedule});
  final Function deleteSchedule;
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18),
      decoration: BoxDecoration(
        color: kBlueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
      ),
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "From",
                      style: kBubblegum_sans20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //-- -- -- -- -- --//
                    Text(
                      DateFormat.jm().format(schedule.dateStart),
                      style: kBubblegum_sans24.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "To",
                      style: kBubblegum_sans20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat.jm().format(schedule.dateEnd),
                      style: kBubblegum_sans24.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => deleteSchedule(schedule.id),
                  child: Image.asset(
                    'images/shape.png',
                    height: 40,
                  ),
                ),
              ],
            ),
            Container(
              width: 250,
              child: Wrap(
                  spacing: 15,
                  runSpacing: 10,
                  children: List<Widget>.generate(schedule.categories.length,
                      (index) {
                    return ShowTimeCategory(schedule.categories[index]);
                  })),
            )
          ],
        ),
      ),
    );
  }
}

class ShowTimeCategory extends StatelessWidget {
  final String name;
  ShowTimeCategory(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        maxRadius: 28,
        backgroundColor: Colors.transparent,
        child: Container(
          child: Image.network(name),
        ),
      ),
    );
  }
}
