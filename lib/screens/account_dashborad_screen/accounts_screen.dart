import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/bloc/account_dashboard_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/screens/child_display_videos/widget/childTimer.dart';
import 'package:save_kids/util/constant.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:save_kids/util/style.dart';

class AccountDashboardScreen extends StatefulWidget {
  @override
  _AccountsDashborasScreenState createState() =>
      _AccountsDashborasScreenState();
}

class _AccountsDashborasScreenState extends State<AccountDashboardScreen> {
  var editMode = true;
  bool showTime = false;

  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/ChildernBK.png",
              fit: BoxFit.cover,
            ),
          ),
          Consumer<AccountDashboardBloc>(
            builder: (conext, accountDashBloc) => Center(
              child: StreamBuilder<Parent>(
                stream: accountDashBloc.parentSession,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    accountDashBloc.parentId = snapshot.data.id;
                    return StreamBuilder<bool>(
                      stream: accountDashBloc.isVerified.stream,
                      builder: (context, isVerified) {
                        if (isVerified.hasData) {
                          if (isVerified.data) {
                            return buildVerifiedUI(accountDashBloc, snapshot);
                          } else {
                            return buildUnverifiedUI(context, accountDashBloc);
                          }
                        }
                        return Center(child: ProgressBar());
                      },
                    );
                  }
                  return ProgressBar();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  SafeArea buildUnverifiedUI(
      BuildContext context, AccountDashboardBloc accountDashBloc) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/envelope.png",
                      height: 80,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'One last step ..  ',
                        style: kBubblegum_sans24,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'verify yor email',
                        style: kBubblegum_sans28,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  height: 58.00,
                  width: 200.00,
                  decoration: BoxDecoration(
                    color: kBlueDarkColor,
                    borderRadius: BorderRadius.circular(84.00),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      if (await accountDashBloc.isEmailVerified &&
                          accountDashBloc.isNew) {
                        await Navigator.pushNamed(
                            context, kAddChildProfileRoute);
                        await accountDashBloc.checkIsEmailVerified;
                        accountDashBloc.isNew = false;
                      }
                    },
                    child: Center(
                      child: Text(
                        "Refresh",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans24.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 58.00,
                  width: 200.00,
                  decoration: BoxDecoration(
                    color: Color(0xfffcbf1e),
                    borderRadius: BorderRadius.circular(84.00),
                  ),
                  child: FlatButton(
                    onPressed: () => accountDashBloc.sendEmailVerification,
                    child: Center(
                      child: Text(
                        "Send the Email again",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans20.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  StreamBuilder<Parent> buildVerifiedUI(
      AccountDashboardBloc accountDashBloc, AsyncSnapshot<Parent> snapshot) {
    return StreamBuilder<Parent>(
        stream: accountDashBloc.parent,
        builder: (context, parentSnap) {
          Parent parent = parentSnap.data ?? Parent();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (parent.password == null) {
                            Navigator.pushNamed(context, kParentDashboardRoute);
                          } else
                            Navigator.pushNamed(context, kParentPinRoute);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              "images/svgs/parents.svg",
                              height: 65,
                            ),
                            Text(
                              "Parents control",
                              style: kBubblegum_sans24.copyWith(
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              StreamBuilder<List<Child>>(
                  stream: accountDashBloc.children,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child: Wrap(
                          children: List<Widget>.generate(
                            snapshot.data.length,
                            (index) => Padding(
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
                                builder: (context, child, value) =>
                                    Transform.scale(
                                  scale: value,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (snapshot.data[index].type ==
                                          "exploratory") {
                                        if (snapshot
                                                .data[index].timer.isComplete ==
                                            true) {
                                          await buildShowModeDialog(context);
                                        } else if (snapshot
                                                .data[index].timer.isComplete ==
                                            false) {
                                          if (snapshot.data[index].specifyVideos
                                                  .length >
                                              0) {
                                            Navigator.pushNamed(context,
                                                kVideoDisplaySpecifyRoute,
                                                arguments:
                                                    snapshot.data[index].id);
                                          } else {
                                            Navigator.pushNamed(
                                                context, kVideoDisplayRoute,
                                                arguments:
                                                    snapshot.data[index].id);
                                          }
                                        }
                                      } else if (snapshot.data[index].type ==
                                          "WC") {
                                        accountDashBloc.changeChosenChild(
                                            snapshot.data[index].id);
                                        accountDashBloc.chosenDate
                                            .add(DateTime.now());
                                        List<Schedule> schedules =
                                            await accountDashBloc
                                                .changeSchedule.first;
                                        Logger().i(schedules.length);
                                        Schedule schedule;
                                        // schedules.forEach((element) {

                                        //   } else {
                                        //     Logger().i("not show time");
                                        //   }
                                        // });

                                        for (int i = 0;
                                            i < schedules.length;
                                            i++) {
                                          if (schedules[i]
                                                  .dateStart
                                                  .isBefore(DateTime.now()) &&
                                              schedules[i]
                                                  .dateEnd
                                                  .isAfter(DateTime.now())) {
                                            schedule = schedules[i];
                                            Logger().i(schedule.id);
                                            Navigator.pushNamed(context,
                                                kChildMainViedoListWatchSchedule,
                                                arguments: schedule);
                                            break;
                                          } else {
                                            await buildShowModeDialog1(context);

                                            Logger().i(
                                              schedules[i].dateStart.toString(),
                                            );
                                            Logger().i(
                                              schedules.length,
                                            );
                                          }
                                        }
                                      }
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Stack(
                                            overflow: Overflow.visible,
                                            alignment: Alignment.center,
                                            children: _displayMode(
                                              snapshot.data[index].imagePath,
                                            )),
                                        Text(
                                          snapshot.data[index].name,
                                          style: GoogleFonts.bubblegumSans(
                                            textStyle:
                                                kBubblegum_sans28.copyWith(
                                              color: kBlueDarkColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return ProgressBar();
                  }),
            ],
          );
        });
  }
}

_displayMode(String imgUrl) {
  List<Widget> _displayMode = [
    CircleAvatar(
      radius: 60,
      backgroundColor: kYellowColor,
    ),
    CircleAvatar(
      backgroundColor: Colors.white,
      radius: 55,
      backgroundImage: NetworkImage(
        imgUrl,
      ),
    ),
  ];

  return _displayMode;
}

_editMode(String childId, String imgUrl, AccountDashboardBloc accountBloc) {
  List<Widget> _editMode = [
    CircleAvatar(
      backgroundColor: Colors.white,
      radius: 45,
      backgroundImage: NetworkImage(
        imgUrl,
      ),
    ),
    CircleAvatar(
      radius: 45,
      backgroundColor: kBlackColor.withOpacity(0.4),
    ),
    Icon(
      Icons.edit,
      color: Colors.white,
      size: 40,
    ),
    Positioned(
      top: -8,
      left: 50,
      child: GestureDetector(
        onTap: () => accountBloc.deleteChild(childId),
        child: Icon(
          Icons.cancel,
          color: kRedColor,
          size: 35,
        ),
      ),
    )
  ];

  return _editMode;
}
