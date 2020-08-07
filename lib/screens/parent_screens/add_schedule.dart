import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/components/parent_components/category_chip.dart';
import 'package:save_kids/components/parent_components/chip_time_picker.dart';
import 'package:save_kids/models/schedule_data.dart';
import 'package:save_kids/models/show_time.dart';
import 'package:save_kids/util/constant.dart';
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
      var tag = "";
      double decimal = result - result.floor();
      String mins = (decimal * 60).floor().toString();

      result.floor() > 0
          ? result.floor() > 1 ? tag = "hours" : tag = "hour"
          : tag = "mins";

      duration = "${result.floor()} : $mins  $tag";
      return duration;
    } else
      return duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurpleColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.15,
              child: Transform.scale(
                scale: 1,
                child: SvgPicture.asset(
                  "images/svgs/background.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Consumer<ScheduleData>(
                builder: (context, scheduleData, child) => Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            buildTitleForm(),
                            Center(
                              child: Text(
                                ScheduleData.daysOfWeek[
                                    scheduleData.currentDate.weekday - 1],
                                style: kBubblegum_sans28.copyWith(
                                    color: kRedColor),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            buildTimePicker(),
                            SizedBox(
                              height: 25,
                            ),
                            buildDuration(),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Select Category :',
                                textAlign: TextAlign.start,
                                style: kBubblegum_sans28.copyWith(
                                    color: kBlueDarkColor),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            buildCategoryChips(),
                            SizedBox(
                              height: 20,
                            ),
                            buildSpecifyChips(),
                            SizedBox(
                              height: 20,
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
          style: kBubblegum_sans32.copyWith(color: kBlueDarkColor),
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
            'Total Duration',
            style: kBubblegum_sans28.copyWith(color: kBlueDarkColor),
          ),
          Text(
            updateDuration().toString(),
            style: kBubblegum_sans24,
          )
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
        CategoryChip(Color(0xff2AC940), 'Science', false),
        CategoryChip(Color(0xffF0A500), 'Toys', false),
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
              style: kBubblegum_sans24.copyWith(color: kBlueDarkColor),
            ),
            SizedBox(
              height: 10,
            ),
            ChipTimePicker(setTime: setStart, time: startTime)
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              'End Time',
              style: kBubblegum_sans24.copyWith(color: kBlueDarkColor),
            ),
            SizedBox(
              height: 10,
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
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            kAddChannelRoute,
          ),
          child: Container(
            height: 40,
            width: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF40BAD5),
              borderRadius: BorderRadius.circular(20.00),
            ),
            child: Text(
              'Specify channels',
              style: kBubblegum_sans20.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF40BAD5),
            borderRadius: BorderRadius.circular(20.00),
          ),
          child: Text(
            'Specify Videos',
            style: kBubblegum_sans20.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Container buildButton() {
    var dateStart = DateTime(
        Provider.of<ScheduleData>(context, listen: false).currentDate.year,
        Provider.of<ScheduleData>(context, listen: false).currentDate.month,
        Provider.of<ScheduleData>(context, listen: false).currentDate.day,
        startTime.hour,
        startTime.minute);

    print(dateStart);
    var dateEnd = DateTime(
        Provider.of<ScheduleData>(context, listen: false).currentDate.year,
        Provider.of<ScheduleData>(context, listen: false).currentDate.month,
        Provider.of<ScheduleData>(context, listen: false).currentDate.day,
        endTime.hour,
        endTime.minute);

    print(dateEnd);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: RaisedButton(
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: kBlueDarkColor,
        onPressed: () {
          Provider.of<ScheduleData>(context, listen: false).addToSchedule(
            new ShowTimeCard(
              childId: Provider.of<ScheduleData>(context, listen: false)
                  .currentChild,
              timeStart: dateStart,
              timeEnd: dateEnd,
            ),
          );
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.00),
        ),
        child: Text(
          'ADD',
          style: kBubblegum_sans24.copyWith(
            fontSize: 21,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
