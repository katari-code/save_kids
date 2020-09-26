import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/add_schedule_bloc.dart';
import 'package:save_kids/components/parent_components/chip_time_picker.dart';
import 'package:save_kids/models/category.dart';

import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

class AddSchedule extends StatefulWidget {
  final String childId;
  final DateTime dateTime;
  AddSchedule(this.childId, this.dateTime);
  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  AddScheduleBloc addScheduleBloc = AddScheduleBloc();
  @override
  void dispose() {
    addScheduleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurpleColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
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
                              '${addScheduleBloc.daysOfWeek[widget.dateTime.weekday - 1]}',
                              style:
                                  kBubblegum_sans28.copyWith(color: kRedColor),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Customize the experiences :',
                              textAlign: TextAlign.start,
                              style: kBubblegum_sans28.copyWith(
                                  color: kBlueDarkColor),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          buildSpecifyChips(addScheduleBloc),
                          SizedBox(
                            height: 20,
                          ),
                          StreamBuilder<bool>(
                              initialData: false,
                              stream: addScheduleBloc.isValidate,
                              builder: (context, snapshot) {
                                return buildButton(
                                    addScheduleBloc, snapshot.data);
                              }),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.cancel,
            size: 32,
            color: kRedColor,
          ),
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
              if (index != 0)
                return GestureDetector(
                  onTap: () {
                    addScheduleBloc
                        .addChosenCategories(categories[index].categoryName);
                  },
                  child: CircleAvatar(
                    backgroundColor: categories[index].isSelected
                        ? Colors.yellow
                        : Colors.transparent,
                    maxRadius: 40,
                    child: Container(
                      child: Image.network(categories[index].imgURl),
                    ),
                  ),
                );
              else {
                return Text("");
              }
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
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF40BAD5),
              borderRadius: BorderRadius.circular(20.00),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Channels',
                    style: kBubblegum_sans20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset('images/svgs/channel.svg'),
                  ),
                ],
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
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF40BAD5),
              borderRadius: BorderRadius.circular(20.00),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Videos',
                    style: kBubblegum_sans20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('images/viedos.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container buildButton(AddScheduleBloc addScheduleBloc, bool isValidate) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: RaisedButton(
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: isValidate ? kBlueDarkColor : Colors.grey,
        onPressed: isValidate
            ? () async {
                addScheduleBloc.childId = widget.childId;
                await addScheduleBloc.addSchedule(widget.dateTime);

                Navigator.pop(context);
              }
            : () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.00),
        ),
        child: Text(
          'Add To Schedule',
          style: kBubblegum_sans24.copyWith(
            fontSize: 21,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
