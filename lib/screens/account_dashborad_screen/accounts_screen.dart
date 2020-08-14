import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:save_kids/bloc/account_dashboard_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            "images/svgs/dashborad_background.svg",
            fit: BoxFit.cover,
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
          Text(
            "Hi",
            style: GoogleFonts.bubblegumSans(
              textStyle: kBubblegum_sans32.copyWith(
                fontSize: 30,
                color: Color(0xff000000),
              ),
            ),
          ),
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
                Text(
                  'Your email is not verified yet',
                  style: kBubblegum_sans28,
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    // await accountDashBloc.checkIsEmailVerified;
                    if (await accountDashBloc.isEmailVerified &&
                        accountDashBloc.isNew) {
                      await Navigator.pushNamed(context, kAddChildProfileRoute);
                      await accountDashBloc.checkIsEmailVerified;
                      accountDashBloc.isNew = false;
                    }
                  },
                  child: Container(
                    height: 58.00,
                    width: 100.00,
                    decoration: BoxDecoration(
                      color: kBlueDarkColor,
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Center(
                      child: Text(
                        "Refresh",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans20.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => accountDashBloc.sendEmailVerification,
                  child: Container(
                    height: 58.00,
                    width: 250.00,
                    decoration: BoxDecoration(
                      color: Color(0xfffcbf1e),
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Center(
                      child: Text(
                        "Send Verification Email",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans24.copyWith(color: Colors.white),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
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
                      child: SvgPicture.asset("images/svgs/parent.svg"),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            editMode = !editMode;
                          },
                        );
                      },
                      child: SvgPicture.asset("images/svgs/edit.svg"),
                    ),
                  ],
                ),
              ),
              Text(
                "Hi, ${parent.name}",
                style: GoogleFonts.bubblegumSans(
                  textStyle: kBubblegum_sans32.copyWith(
                    fontSize: 30,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Who is using the app now ?",
                style: GoogleFonts.capriola(
                  textStyle: kBubblegum_sans32.copyWith(
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<List<Child>>(
                  stream: accountDashBloc.children,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GridView.count(
                            primary: false,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List<Widget>.generate(
                              snapshot.data.length == 4
                                  ? snapshot.data.length
                                  : snapshot.data.length + 1,
                              (index) => snapshot.data.length == 4
                                  ? CustomAnimation(
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
                                          GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, kVideoDisplayRoute,
                                              arguments:
                                                  snapshot.data[index].id);
                                        },
                                        child: Column(children: <Widget>[
                                          Stack(
                                            alignment: Alignment.center,
                                            overflow: Overflow.visible,
                                            children: editMode
                                                ? _displayMode(
                                                    snapshot
                                                        .data[index].imagePath,
                                                  )
                                                : _editMode(
                                                    snapshot.data[index].id,
                                                    snapshot
                                                        .data[index].imagePath,
                                                    accountDashBloc,
                                                  ),
                                          ),
                                          Text(
                                            snapshot.data[index].name,
                                            style: GoogleFonts.bubblegumSans(
                                              textStyle:
                                                  kBubblegum_sans28.copyWith(
                                                      color: kBlueDarkColor),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )
                                  : index == snapshot.data.length
                                      ? CustomAnimation(
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
                                              onTap: () => Navigator.pushNamed(
                                                  context,
                                                  kAddChildProfileRoute),
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        radius: 45,
                                                        backgroundColor:
                                                            kYellowColor,
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
                                                    style:
                                                        GoogleFonts.capriola(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : CustomAnimation(
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
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, kVideoDisplayRoute,
                                                    arguments: snapshot
                                                        .data[index].id);
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Stack(
                                                    overflow: Overflow.visible,
                                                    alignment: Alignment.center,
                                                    children: editMode
                                                        ? _displayMode(
                                                            snapshot.data[index]
                                                                .imagePath,
                                                          )
                                                        : _editMode(
                                                            snapshot
                                                                .data[index].id,
                                                            snapshot.data[index]
                                                                .imagePath,
                                                            accountDashBloc,
                                                          ),
                                                  ),
                                                  Text(
                                                    snapshot.data[index].name,
                                                    style: GoogleFonts
                                                        .bubblegumSans(
                                                      textStyle:
                                                          kBubblegum_sans28
                                                              .copyWith(
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
