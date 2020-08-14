import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/bloc/kids_accounts_specify_video_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/preference/prefs_singleton.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';

class ChildrenScreenAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurpleColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'images/svgs/Back_video.svg',
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "kids Accounts",
                    style: kBubblegum_sans40.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  child: Container(
                    height: 400,
                    width: 350,
                    decoration: BoxDecoration(),
                    child: Consumer<KidsAccountsSpecifyVideosBloc>(
                      builder: (context, kidsAccountsSpecifyVideosBloc) {
                        return StreamBuilder<Parent>(
                          stream: kidsAccountsSpecifyVideosBloc.parentSession,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              kidsAccountsSpecifyVideosBloc.parentId =
                                  snapshot.data.id;
                              return StreamBuilder<List<Child>>(
                                  stream:
                                      kidsAccountsSpecifyVideosBloc.children,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return GridView.count(
                                        primary: false,
                                        padding: EdgeInsets.all(15),
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2,
                                        children: List<Widget>.generate(
                                            snapshot.data.length,
                                            (index) => CustomAnimation(
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  delay: Duration(
                                                    milliseconds:
                                                        (800 * 2).round(),
                                                  ),
                                                  curve: Curves.elasticOut,
                                                  tween: Tween<double>(
                                                    begin: 0,
                                                    end: 1,
                                                  ),
                                                  builder:
                                                      (context, child, value) =>
                                                          GestureDetector(
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator
                                                              .pushNamed(
                                                        context,
                                                        kSpecifyVideoRoute,
                                                      );
                                                      final String viedoList =
                                                          Video.encodeVideos(
                                                              result);
                                                      PreferenceUtils.setString(
                                                          snapshot
                                                              .data[index].id,
                                                          viedoList);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: kBlueColor
                                                            .withOpacity(0.7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                overflow:
                                                                    Overflow
                                                                        .visible,
                                                                children:
                                                                    _displayMode(
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .imagePath,
                                                                )),
                                                            Text(
                                                              snapshot
                                                                  .data[index]
                                                                  .name,
                                                              style: GoogleFonts
                                                                  .bubblegumSans(
                                                                textStyle: kBubblegum_sans28
                                                                    .copyWith(
                                                                        color:
                                                                            kBlueDarkColor),
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                )),
                                      );
                                    }
                                    return ProgressBar();
                                  });
                            } else {
                              return Text("data");
                            }
                          },
                        );
                      },
                    ),
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

_displayMode(String imgUrl) {
  List<Widget> _displayMode = [
    CircleAvatar(
      radius: 50,
      backgroundColor: kYellowColor,
    ),
    CircleAvatar(
      backgroundColor: Colors.white,
      radius: 45,
      backgroundImage: NetworkImage(
        imgUrl,
      ),
    ),
  ];

  return _displayMode;
}
