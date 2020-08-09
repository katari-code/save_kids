import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/models/schedule_data.dart';
import 'package:save_kids/models/show_time.dart';
import 'package:save_kids/util/style.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({this.showTimeCard, this.schedule});

  final ShowTimeCard showTimeCard;
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
                      DateFormat.jm().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              schedule.dateStart)),
                      style: kBubblegum_sans20.copyWith(
                        fontSize: 24,
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
                      DateFormat.jm().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              schedule.dateEnd)),
                      style: kBubblegum_sans20.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Provider.of<ScheduleData>(context, listen: false)
                      .deleteTheShowTimeCard(showTimeCard),
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
                spacing: 30,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(2),
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kRedDarkColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Cartoon",
                        textAlign: TextAlign.center,
                        style: kBubblegum_sans20.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kRedDarkColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Cartoon",
                        textAlign: TextAlign.center,
                        style: kBubblegum_sans20.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
