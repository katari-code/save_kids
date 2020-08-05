import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key key,
  }) : super(key: key);

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

                    //--           --//
                    Text(
                      "4:00 PM",
                      style: kBubblegum_sans20,
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
                      "4:30 PM",
                      style: kBubblegum_sans20,
                    ),
                  ],
                ),
                Image.asset(
                  'images/shape.png',
                  height: 40,
                ),
              ],
            ),
            Container(
              width: 250,
              child: Wrap(
                spacing: 30,
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }
}
