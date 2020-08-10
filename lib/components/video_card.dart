import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class VideoCardEnhanced extends StatelessWidget {
  const VideoCardEnhanced({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 180.00,
      width: 320.00 / 1.15,
      child: Stack(
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
                      "00:00",
                      style: kCapriola16.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 320.00 / 1.15,
                color: kPurpleColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Hi from the athor side ",
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
        color: kBlueDarkColor,
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
