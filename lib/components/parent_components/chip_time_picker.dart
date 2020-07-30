import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class ChipTimePicker extends StatelessWidget {
  const ChipTimePicker({
    @required this.setTime,
    @required this.time,
  });

  final TimeOfDay time;
  final Function setTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.00,
      width: 150.00,
      child: GestureDetector(
        onTap: () async {
          final result = await showTimePicker(
            context: context,
            initialTime: time,
          );
          if (result != null) setTime(result);
        },
        child: Align(
          alignment: Alignment.center,
          child: Text(
            time.format(context),
            style: kBubblegum_sans28.copyWith(
                color: kBlueDarkColor, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: kYellowColor,
        borderRadius: BorderRadius.circular(20.00),
      ),
    );
  }
}
