import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final Color color;
  CategoryChip(this.color, this.category, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14.00),
          border: isSelected
              ? Border.all(color: Colors.green, width: 1)
              : Border.all(width: 0)),
      child: Text(
        category,
        style: kBubblegum_sans24,
      ),
    );
  }
}
