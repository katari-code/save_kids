import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/util/style.dart';

class VideoCardEnhanced extends StatelessWidget {
  String videoTitle;
  final String image;

  VideoCardEnhanced({this.videoTitle, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.00,
      width: 270.00,
      margin: EdgeInsets.only(right: 20, bottom: 15),
      child: Stack(
        overflow: Overflow.clip,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.report,
                color: Colors.yellow,
                size: 40,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  image,
                  scale: 1,
                ),
                fit: BoxFit.cover,
              ),
              color: kBlueColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.07),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.00),
                topRight: Radius.circular(25.00),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.black.withOpacity(0.15),
                    child: Text(
                      "    ",
                      style: kCapriola16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 320.00,
                height: 140,
                color: kBlackColor.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    videoTitle,
                    style: kBubblegum_sans24.copyWith(
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: kBlueColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.07),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.00),
          topRight: Radius.circular(25.00),
        ),
      ),
    );
  }
}
