import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/schedule_data.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/widgets/schedule_card.dart';
import 'package:save_kids/util/style.dart';

class AvatrsCarousel extends StatefulWidget {
  @override
  _AvatrsCarouselState createState() => _AvatrsCarouselState();
}

class _AvatrsCarouselState extends State<AvatrsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Consumer<KidsData>(builder: (context, kidsData, child) {
            var kids = kidsData.kids;
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 150,
                viewportFraction: 0.30,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
                onPageChanged: (index, CarouselPageChangedReason reason) {
                  Provider.of<ScheduleData>(context, listen: false)
                      .currentChild = index;
                },
                scrollDirection: Axis.horizontal,
              ),
              itemCount: kids.length,
              itemBuilder: (BuildContext context, int itemIndex) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: kYellowColor,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                kids[itemIndex].imagePath,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      kids[itemIndex].name,
                      style: kBubblegum_sans24.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
