import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';

import 'widget/category_carousel.dart';

class ChildMainViedoList extends StatefulWidget {
  @override
  _ChildMainViedoListState createState() => _ChildMainViedoListState();
}

class _ChildMainViedoListState extends State<ChildMainViedoList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: [
          Transform.scale(
            scale: 1.2,
            child: SvgPicture.asset(
              "images/BKgChildViedoList.svg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.3),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List<GestureDetector>.generate(
                    categoriesList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = categoriesList[index].index;
                        });
                      },
                      child: CustomAnimation(
                        duration: Duration(milliseconds: 800),
                        delay: Duration(
                          milliseconds: (800 * 2).round(),
                        ),
                        curve: Curves.elasticOut,
                        tween: Tween<double>(
                          begin: 0,
                          end: 1,
                        ),
                        builder: (context, child, value) => Container(
                          child: Transform.scale(
                            scale: value,
                            child: Image.network(
                              categoriesList[index].imgURl,
                              width:
                                  selectedIndex != categoriesList[index].index
                                      ? MediaQuery.of(context).size.width / 9
                                      : MediaQuery.of(context).size.width / 5,
                              height: 160,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Wrap(
                //   children: List<VideoCardEnhanced>.generate(
                //     categoriesList.length,
                //     (index) => VideoCardEnhanced(),
                //   ),
                // ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 50.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: 50,
                    itemBuilder: (context, index) => VideoCardEnhanced(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
