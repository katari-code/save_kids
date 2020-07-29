import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/components/parent_components/category_chip.dart';
import 'package:save_kids/components/parent_components/chip_time_picker.dart';
import 'package:save_kids/util/style.dart';

class AddSchedule extends StatefulWidget {
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String duration = '';
  setStart(TimeOfDay time) {
    setState(() {
      startTime = time;
    });
  }

  setEnd(TimeOfDay time) {
    setState(() {
      endTime = time;
    });
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  updateDuration() {
    final start = toDouble(startTime);
    final end = toDouble(endTime);
    if (start < end) {
      final result = end - start;

      double decimal = result - result.floor();
      String mins = (decimal * 60).floor().toString();
      duration = "${result.floor()} : $mins";
      return duration;
    } else
      return duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.15,
              child: Transform.scale(
                scale: 5,
                child: SvgPicture.asset("images/svgs/background.svg"),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        buildTitleForm(),
                        Center(
                          child: Text(
                            'Monday',
                            style: kBubblegum_sans2.copyWith(color: kRedColor),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        buildTimePicker(),
                        SizedBox(
                          height: 18,
                        ),
                        buildDuration(),
                        SizedBox(
                          height: 18,
                        ),
                        Center(
                          child: Text(
                            'Select Category',
                            style: kBubblegum_sans2.copyWith(
                                color: kBlueDarkColor, fontSize: 21),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        buildCategoryChips(),
                        SizedBox(
                          height: 18,
                        ),
                        buildSpecifyChips(),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Repeat for all days',
                              style: kGoogle_style.copyWith(
                                  color: Colors.grey, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildButton()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildTitleForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Add Schedule',
          style: kBubblegum_sans1.copyWith(color: kBlueDarkColor),
        ),
        SizedBox(
          width: 18,
        ),
        Icon(
          Icons.cancel,
          size: 32,
          color: kRedColor,
        )
      ],
    );
  }

  Center buildDuration() {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Duration',
            style:
                kBubblegum_sans2.copyWith(color: kBlueDarkColor, fontSize: 21),
          ),
          Text(updateDuration().toString(),
              style: kBubblegum_sans2.copyWith(
                  color: kBlueDarkColor, fontSize: 21))
        ],
      ),
    );
  }

  Wrap buildCategoryChips() {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 10,
      spacing: 10,
      children: <Widget>[
        CategoryChip(kYellowColor, 'Everything', true),
        CategoryChip(kRedColor, 'Cartoon', false),
        CategoryChip(kYellowColor, 'Science', false),
        CategoryChip(kBlueDarkColor, 'Toys', false),
      ],
    );
  }

  Widget buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Start Time',
              style: kBubblegum_sans2.copyWith(
                  color: kBlueDarkColor, fontSize: 21),
            ),
            SizedBox(
              height: 18,
            ),
            ChipTimePicker(setTime: setStart, time: startTime)
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'End Time',
              style: kBubblegum_sans2.copyWith(
                  color: kBlueDarkColor, fontSize: 21),
            ),
            SizedBox(
              height: 18,
            ),
            ChipTimePicker(setTime: setEnd, time: endTime)
          ],
        ),
      ],
    );
  }

  Row buildSpecifyChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 40,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF40BAD5),
            borderRadius: BorderRadius.circular(14.00),
          ),
          child: Text(
            'Specify channels',
            style: kBubblegum_sans3,
          ),
        ),
        Container(
          height: 40,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF40BAD5),
            borderRadius: BorderRadius.circular(14.00),
          ),
          child: Text(
            'Specify Videos',
            style: kBubblegum_sans3,
          ),
        ),
      ],
    );
  }

  Container buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: RaisedButton(
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: kBlueDarkColor,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.00),
        ),
        child: Text(
          'ADD',
          style: kGoogle_style.copyWith(fontSize: 21),
        ),
      ),
    );
  }
}
