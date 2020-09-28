import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/bloc/parent_dashboard_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/screens/child_display_videos/widget/childTimer.dart';
import 'package:save_kids/screens/show_models/commercial_dialogue.dart';
import 'package:save_kids/services/auth_service_provider.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:toggle_switch/toggle_switch.dart';

final String testID = "safe_video_kids_ki_bv";

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _showModalSheet(AuthBloc authBloc) {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) => CommercialDialogue(
        auth: authBloc,
      ),
    );
  }

  //  parent.password == null
  //                                           ? Text(
  //                                               'Add Password to your Account to lock The Parent Mode!',
  //                                               style:
  //                                                   kBubblegum_sans24.copyWith(
  //                                                       color: kRedColor,
  //                                                       fontWeight:
  //                                                           FontWeight.normal),
  //                                             )
  //                                           : Text('')

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Future.delayed(Duration(seconds: 2), () => buildShowModeDialog2(context));
    return Scaffold(
      backgroundColor: kBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  'images/svgs/Back_video.svg',
                  height: 70,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, kParentSettingsRoute),
                  child: SvgPicture.asset(
                    "images/svgs/settings.svg",
                    height: 55,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    await AuthServiceProvider().signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, kOnboradingScreen, (route) => false);
                  },
                  child: SvgPicture.asset(
                    "images/svgs/logout.svg",
                    height: 55,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<AuthBloc>(
        builder: (context, authBloc) => Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "images/ChildernBK.png",
                fit: BoxFit.cover,
              ),
            ),
            Scrollbar(
              isAlwaysShown: true,
              controller: controller,
              child: SingleChildScrollView(
                controller: controller,
                child: SafeArea(
                  child: StreamBuilder<Parent>(
                      stream: authBloc.parent,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Parent parent = snapshot.data;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 21, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                            'Hello, ${parent.name}',
                                            style: kBubblegum_sans32.copyWith(
                                                color: kBlueDarkColor),
                                          ),
                                          Text(
                                            'Monitor your children accounts',
                                            style: kBubblegum_sans24.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          parent.password == null
                                              ? Text(
                                                  'Add Password to your Account to lock The Parent Mode!',
                                                  style: kBubblegum_sans20
                                                      .copyWith(
                                                          color:
                                                              Colors.redAccent,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                )
                                              : Text('')
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            parent.isPremium == "free_account"
                                                ? _showModalSheet(authBloc)
                                                : Navigator.pushNamed(context,
                                                    kWatchSchdeuleRoute);
                                          },
                                          child: Container(
                                            width: 150,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: kPurpleColor,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.40),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: SvgPicture.asset(
                                                      "images/Iconawesome-crown.svg",
                                                      color: parent.isPremium ==
                                                              "free_account"
                                                          ? Colors.grey[50]
                                                          : Color(0xffEDA500),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                SvgPicture.asset(
                                                  'images/svgs/schedule.svg',
                                                  height: 60,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      "Watch Schedule",
                                                      style: kBubblegum_sans20
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, kHistoryWatchRoute),
                                          child: Container(
                                            width: 150,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color(0xffFC7A01),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Image.asset(
                                                  'images/whatchHistory.png',
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Watch History",
                                                  style: kBubblegum_sans20
                                                      .copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 38,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "Kids Profiles",
                                      style: kBubblegum_sans32.copyWith(
                                          color: kBlueDarkColor),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    KidsProfiles(
                                      isPremuime: parent.isPremium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        return Center(child: ProgressBar());
                      }),
                ),
              ),
            ),

            // Center(
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 150,
            //     // width: 300,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // Widget buildParentFeatures() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       InkWell(
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           color: kYellowColor,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 child: SvgPicture.asset(
  //                   "images/svgs/schedule.svg",
  //                 ),
  //                 padding: EdgeInsets.only(
  //                   top: 0,
  //                   left: 20,
  //                   right: 20,
  //                 ),
  //                 height: 100,
  //                 width: 115,
  //               ),
  //               Text(
  //                 'Schedule',
  //                 style: kBubblegum_sans24,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 32,
  //       ),
  //       InkWell(
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           color: kPurpleColor,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 child: SvgPicture.asset(
  //                   "images/svgs/schedule.svg",
  //                 ),
  //                 padding: EdgeInsets.only(top: 0, left: 20, right: 20),
  //                 height: 100,
  //                 width: 115,
  //               ),
  //               Text(
  //                 'History',
  //                 style: kBubblegum_sans24,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

}

class KidsProfiles extends StatelessWidget {
  final isPremuime;
  KidsProfiles({this.isPremuime});
  @override
  Widget build(BuildContext context) {
    return Consumer<ParentDashBoardBloc>(
      builder: (context, parentDashBoardBloc) => StreamBuilder<List<Child>>(
          stream: parentDashBoardBloc.children.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Column(
                    children: List.generate(
                      snapshot.data.length,
                      (index) => KidsCard(
                        parentDashBoardBloc: parentDashBoardBloc,
                        child: snapshot.data[index],
                        isPremium: isPremuime,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  snapshot.data.length < 4
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
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
                            builder: (context, child, value) => Transform.scale(
                              scale: value,
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, kAddChildProfileRoute),
                                child: Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 45,
                                          backgroundColor: kYellowColor,
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 70,
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Add a child profile",
                                      style: kBubblegum_sans32.copyWith(
                                          color: kBlueDarkColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(""),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            } else {
              return ProgressBar();
            }
          }),
    );
  }
}

class KidsCard extends StatelessWidget {
  final ParentDashBoardBloc parentDashBoardBloc;
  final Child child;
  final isPremium;
  KidsCard({this.parentDashBoardBloc, this.child, this.isPremium});
  @override
  Widget build(BuildContext context) {
    int toggleSwitchIndex = child.type == "WC"
        ? 2
        : child.type == "exploratory"
            ? 0
            : child.type == "specify_videos"
                ? 1
                : 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350.0,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white, width: 5),
          color: Color(0xffFEFF1F),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 45,
                      child: CircleAvatar(
                        backgroundColor: kBlueColor,
                        maxRadius: 40,
                        backgroundImage: NetworkImage(child.imagePath),
                      ),
                    ),
                    Text(
                      child.name,
                      style: kBubblegum_sans24,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Row(
                          mainAxisAlignment:
                              child.type != "WC" && child.type != "exploratory"
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async => await parentDashBoardBloc
                                  .deleteChild(child.id),
                              child: SvgPicture.asset(
                                'images/svgs/trash.svg',
                                height: 50,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                kChildEditProfileRoute,
                                arguments: child.id,
                              ),
                              child: SvgPicture.asset(
                                'images/svgs/edit.svg',
                                height: 50,
                              ),
                            ),
                            if (child.type != "WC" &&
                                child.type != "exploratory")
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, kSpecifyVideoSearchChild,
                                    arguments: child.id),
                                child: SvgPicture.asset(
                                  'images/svgs/videosicon.svg',
                                  height: 50,
                                ),
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "Account modes :",
              style: kBubblegum_sans24,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleSwitch(
                  minWidth: 100.0,
                  initialLabelIndex: toggleSwitchIndex,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  labels: ['Explore 🚀', 'Custom 🎞️', 'schedule 📅'],
                  activeBgColors: [Colors.blue, Colors.pink, Colors.purple],
                  onToggle: (index) async {
                    await parentDashBoardBloc.changeMode(child.id, index);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
