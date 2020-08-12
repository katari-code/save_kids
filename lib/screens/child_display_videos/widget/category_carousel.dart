import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/models/category.dart';

class CategoryCarousel extends StatefulWidget {
  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider.builder(
              options: CarouselOptions(
                height: 150,
                viewportFraction: 0.4,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
                onPageChanged: (index, CarouselPageChangedReason reason) {},
                scrollDirection: Axis.horizontal,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (BuildContext context, int itemIndex) {
                return Container(
                  child: Image.network(
                    categoriesList[itemIndex].imgURl,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
