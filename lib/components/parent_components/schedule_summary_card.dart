import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class ScheduleSummaryCard extends StatelessWidget {
  final String date;
  final String time;
  final String childImage;
  ScheduleSummaryCard(this.date, this.time, this.childImage);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPurpleColor,
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Today',
                    style: kBubblegum_sans24.copyWith(
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    'From 9 to 10pm',
                    style: kBubblegum_sans24.copyWith(
                        fontWeight: FontWeight.normal),
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: kRedColor,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text('Cartoon'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: kYellowColor,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text('Cartoon'),
                      ),
                    ],
                  )
                ],
              ),
              CircleAvatar(
                radius: 60,
                backgroundColor: kYellowColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
