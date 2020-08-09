import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/util/style.dart';

class AvatrsCarousel extends StatefulWidget {
  final List<Child> children;
  final Function chosenChild;
  AvatrsCarousel(this.children, this.chosenChild);
  @override
  _AvatrsCarouselState createState() => _AvatrsCarouselState();
}

class _AvatrsCarouselState extends State<AvatrsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.30,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              enlargeCenterPage: true,
              onPageChanged: (index, CarouselPageChangedReason reason) {
                widget.chosenChild(widget.children[index].id);
              },
              scrollDirection: Axis.horizontal,
            ),
            itemCount: widget.children.length,
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
                              widget.children[itemIndex].imagePath,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.children[itemIndex].name,
                    style: kBubblegum_sans24.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
