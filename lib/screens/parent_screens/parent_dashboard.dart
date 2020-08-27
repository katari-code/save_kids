import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/bloc/parent_dashboard_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/premium_model.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/auth_service_provider.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
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
    return Scaffold(
      backgroundColor: kBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, kParentSettingsRoute),
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

            SingleChildScrollView(
              child: SafeArea(
                child: StreamBuilder<Parent>(
                    stream: authBloc.parent,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Parent parent = snapshot.data;

                        return Column(
                          children: <Widget>[
                            SafeArea(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 40,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    color: kBlueDarkColor,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await popUpShow(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        "Free Verison",
                                        style: kBubblegum_sans20.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 21, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Hello, ${parent.name}',
                                    style: kBubblegum_sans32.copyWith(
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'Monitor your children account',
                                    style: kBubblegum_sans24.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  parent.password == null
                                      ? Text(
                                          'Add Password to your Account to lock The Parent Mode!',
                                          style: kBubblegum_sans20.copyWith(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.normal),
                                        )
                                      : Text('')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, kWatchSchdeuleRoute),
                                  child: Container(
                                    width: 170,
                                    height: 150,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kPurpleColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'images/svgs/schedule.svg',
                                          height: 80,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Watch Schedule",
                                              style: kBubblegum_sans24.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
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
                                    width: 170,
                                    height: 150,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffFFA846),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'images/whatchHistory.png',
                                          height: 90,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Watch History",
                                          style: kBubblegum_sans24.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Kids Profiles",
                              style: kBubblegum_sans44.copyWith(
                                color: kBlueDarkColor,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            KidsProfiles(),
                            BottomAppBar(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.transparent,
                              child: GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  kChildAccountRoute,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(28),
                                    ),
                                    color: kYellowColor,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Switch To Kids',
                                    style: kBubblegum_sans40.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return Center(child: ProgressBar());
                    }),
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                                      "Create profile",
                                      style: kBubblegum_sans24.copyWith(
                                          color: Colors.black),
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
  KidsCard({this.parentDashBoardBloc, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350.0,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white, width: 5),
          color: Color(0xFFFFC300),
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
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async =>
                                await parentDashBoardBloc.deleteChild(child.id),
                            child: SvgPicture.asset(
                              'images/svgs/trash.svg',
                              height: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              kChildEditProfileRoute,
                              arguments: child.id,
                            ),
                            child: SvgPicture.asset(
                              'images/svgs/edit.svg',
                              height: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, kSpecifyVideoSearchChild,
                                arguments: child.id),
                            child: SvgPicture.asset(
                              'images/svgs/videosicon.svg',
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ToggleSwitch(
                        minWidth: 110.0,
                        initialLabelIndex: 1,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        labels: ["explor", 'schedule'],
                        activeBgColors: [Colors.blue, Colors.pink],
                        onToggle: (index) async {
                          await parentDashBoardBloc.changeMode(child.id, index);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
