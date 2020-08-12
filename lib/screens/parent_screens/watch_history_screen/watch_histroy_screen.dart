import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/util/style.dart';

class WatchHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 80,
                        // width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: kYellowColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              "Watch History",
                              style: kBubblegum_sans40.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Consumer<KidsData>(
                  //   builder: (context, kidsData, child) {
                  //     var kids = kidsData.kids;
                  //     return Column(
                  //       children: [
                  //         ...List<Widget>.generate(
                  //           kids.length,
                  //           (index) => Column(
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.all(15.0),
                  //                 child: Row(
                  //                   children: [
                  //                     Stack(
                  //                       children: [
                  //                         Center(
                  //                           child: CircleAvatar(
                  //                             backgroundColor: kYellowColor,
                  //                             radius: 40,
                  //                             child: CircleAvatar(
                  //                               backgroundColor: Colors.white,
                  //                               radius: 35,
                  //                               backgroundImage: NetworkImage(
                  //                                 kids[index].imagePath,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     SizedBox(
                  //                       width: 15,
                  //                     ),
                  //                     Text(
                  //                       kids[index].name,
                  //                       style: kBubblegum_sans32.copyWith(
                  //                         color: Colors.white,
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 190,
                  //                 child: ListView.builder(
                  //                   scrollDirection: Axis.horizontal,
                  //                   padding: EdgeInsets.only(left: 15),
                  //                   itemCount: 4,
                  //                   itemBuilder: (context, index) =>
                  //                       VideoCardEnhanced(),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
            
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
