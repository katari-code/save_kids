import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as provider;
import 'package:save_kids/bloc/add_schedule_bloc.dart';
import 'package:save_kids/components/parent_components/category_chip.dart';
import 'package:save_kids/components/parent_components/chip_time_picker.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/schedule_data.dart';

import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

class AddSchedule extends StatefulWidget {
  final String childId = 'V8J4zstRK4tHm3J99kF3';
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
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
              child: Consumer<AddScheduleBloc>(
                builder: (context, addScheduleBloc) =>
                    provider.Consumer<ScheduleData>(
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
                              buildTimePicker(addScheduleBloc),
                              SizedBox(
                                height: 25,
                              ),
                              buildDuration(addScheduleBloc),
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
                              buildCategoryChips(addScheduleBloc),
                              SizedBox(
                                height: 20,
                              ),
                              buildSpecifyChips(addScheduleBloc),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              buildButton(addScheduleBloc)
                            ],
                          ),
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

  Widget buildDuration(AddScheduleBloc addScheduleBloc) {
    return StreamBuilder<String>(
        stream: addScheduleBloc.duration,
        builder: (context, snapshot) {
          final duration = snapshot.data ?? '';
          return Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Total Duration',
                  style: kBubblegum_sans28.copyWith(color: kBlueDarkColor),
                ),
                Text(
                  duration,
                  style: kBubblegum_sans24,
                )
              ],
            ),
          );
        });
  }

  Widget buildCategoryChips(AddScheduleBloc addScheduleBloc) {
    return StreamBuilder<List<Category>>(
        stream: addScheduleBloc.categoryList,
        builder: (context, snapshot) {
          List<Category> categories = snapshot.data ?? [];
          return Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 10,
            children: List<Widget>.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () => addScheduleBloc
                    .addChosenCategories(categories[index].categoryName),
                child: CategoryChip(
                    categories[index].color,
                    categories[index].categoryName,
                    categories[index].isSelected),
              );
            }),
          );
        });
  }

  Widget buildTimePicker(AddScheduleBloc addScheduleBloc) {
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
            ChipTimePicker(
                setTime: addScheduleBloc.changeTimeStart,
                time: addScheduleBloc.timeStart)
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
            ChipTimePicker(
                setTime: addScheduleBloc.changeTimeEnd,
                time: addScheduleBloc.timeEnd)
          ],
        ),
      ],
    );
  }

  Row buildSpecifyChips(AddScheduleBloc addScheduleBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            final result =
                await Navigator.pushNamed(context, kSpecifyChannelsRoute);
            if (result != null) addScheduleBloc.addChosenChannels(result);
          },
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
        GestureDetector(
          onTap: () async {
            final result =
                await Navigator.pushNamed(context, kSpecifyVideoRoute);
            if (result != null) addScheduleBloc.addChosenVideos(result);
          },
          child: Container(
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
        ),
      ],
    );
  }

  Container buildButton(AddScheduleBloc addScheduleBloc) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: RaisedButton(
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: kBlueDarkColor,
        onPressed: () async {
          addScheduleBloc.childId = widget.childId;
          await addScheduleBloc.addSchedule();
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
