import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/premium_model.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/auth_service_provider.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "images/background.png",
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SafeArea(
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
            ),

            SafeArea(
              child: StreamBuilder<Parent>(
                  stream: authBloc.parentSession,
                  builder: (context, session) {
                    if (session.hasData) {
                      return StreamBuilder<Parent>(
                          stream: authBloc.parentData(session.data.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Parent parent = snapshot.data;

                              return Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 21, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                                style:
                                                    kBubblegum_sans20.copyWith(
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              )
                                            : Text('')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 15),
                                  //   child: GestureDetector(
                                  //     onTap: () => Navigator.pushNamed(
                                  //         context, kWatchSchdeuleRoute),
                                  //     child: Container(
                                  //       padding: EdgeInsets.all(15),
                                  //       decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(8),
                                  //         color: kPurpleColor,
                                  //       ),
                                  //       child: Row(
                                  //         children: <Widget>[
                                  //           SvgPicture.asset(
                                  //               'images/svgs/schedule.svg'),
                                  //           SizedBox(
                                  //             width: 15,
                                  //           ),
                                  //           Column(
                                  //             children: <Widget>[
                                  //               Text(
                                  //                 "Watch Schedule",
                                  //                 style: kBubblegum_sans32
                                  //                     .copyWith(
                                  //                   color: Colors.white,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, kHistoryWatchRoute),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffFFA846),
                                        ),
                                        child: Row(
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
                                              style: kBubblegum_sans32.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            kSpecifyVideoChildrenAccount);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffFF7E71),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                              'images/viedos.png',
                                              height: 70,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Specify Videos",
                                              style: kBubblegum_sans32.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return ProgressBar();
                          });
                    }
                    return Center(child: ProgressBar());
                  }),
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
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: kBlueColor,
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
            height: MediaQuery.of(context).size.height * 0.1,
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
