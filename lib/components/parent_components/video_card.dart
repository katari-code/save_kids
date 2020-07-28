import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/util/style.dart';

class VideoCard extends StatelessWidget {
  final String image;
  final String videoTitle;
  final String description;

  VideoCard(this.image, this.videoTitle, this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: kPurpleColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SvgPicture.asset(
            image,
            height: 50,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 4,
              spacing: 64,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: <Widget>[
                Text(videoTitle),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
