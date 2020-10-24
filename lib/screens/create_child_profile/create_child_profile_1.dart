import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/bloc/create_child_profile_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/stream_input_field.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/screens/show_models/commercial_dialogue.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

import 'create_child_profile.dart';

class WalkthroghProfile extends StatefulWidget {
  @override
  _WalkthroghProfileState createState() => _WalkthroghProfileState();
}

class _WalkthroghProfileState extends State<WalkthroghProfile> {
  int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  Duration _duration = Duration(hours: 0, minutes: 30);
  Timer _timer = new Timer();
  CreateChildProfileBloc createChildBloc = CreateChildProfileBloc();

  int _currentPage = 0;
  int _toggleIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
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
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   child: Opacity(
          //     opacity: 0.2,
          //     child: Image.asset(
          //       "images/background.png",
          //       repeat: ImageRepeat.repeat,
          //     ),
          //   ),
          // ),
          Container(
            height: 650.0,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(" "),
                            ),
                          ),
                          Expanded(
                            flex: 99,
                            child: SvgPicture.asset(
                              "images/logo-enhanceds.svg",
                              height: 90,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "1. Create your Child Profile",
                      style: kBubblegum_sans28.copyWith(
                        color: kBlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 400,
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext _) => StatefulBuilder(
                                builder: (context, setStaste) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: StreamBuilder<Object>(
                                        stream: createChildBloc.imageAvatar,
                                        initialData: createChildBloc.avatars[0],
                                        builder: (context, snapshot) {
                                          return Column(
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundColor: kYellowColor,
                                                radius: 60,
                                                child: CircleAvatar(
                                                  radius: 55,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: NetworkImage(
                                                    snapshot.data,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Flexible(
                                                child: GridView.count(
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  crossAxisCount: 3,
                                                  children:
                                                      List<Widget>.generate(
                                                    createChildBloc
                                                        .avatars.length,
                                                    (index) => GestureDetector(
                                                      onTap: () {
                                                        createChildBloc
                                                            .changeImageAvatar(
                                                          createChildBloc
                                                              .avatars[index],
                                                        );
                                                      },
                                                      child: Stack(
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            radius: 45,
                                                            backgroundColor: createChildBloc
                                                                            .avatars[
                                                                        index] ==
                                                                    snapshot
                                                                        .data
                                                                ? kPurpleColor
                                                                : kYellowColor,
                                                          ),
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              radius: 40,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                createChildBloc
                                                                        .avatars[
                                                                    index],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: AgeChip(
                                                  color: kBlueDarkColor,
                                                  text: "Done",
                                                  highet: 60.0,
                                                  width: 120.0,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            child: StreamBuilder<Object>(
                                stream: createChildBloc.imageAvatar,
                                initialData: createChildBloc.avatars[0],
                                builder: (context, snapshot) {
                                  return Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        radius: 55,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 50,
                                          backgroundImage:
                                              NetworkImage(snapshot.data),
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          StreamReusablefield(
                            stream: createChildBloc.childName,
                            label: 'Child name',
                            onChangeFunction: createChildBloc.changeChildName,
                            isPass: false,
                          ),
                          buildAgeChips(createChildBloc),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          Expanded(
                            flex: 200,
                            child: Transform.translate(
                              offset: Offset(-15, 0),
                              child: SvgPicture.asset(
                                "images/logo-enhanceds.svg",
                                height: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "2. Choose Account mode",
                      style: kBubblegum_sans28.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 400,
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Container(
                              height: 110,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Color(0xffff5133),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                        "images/default_tag.svg",
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          width: 320 - 94.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "ُExplor Mode 🚀",
                                                    style: kBubblegum_sans24
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Let your child enjoy and watch from five selection categories for time",
                                                style:
                                                    kBubblegum_sans16.copyWith(
                                                  color: Color(0xffFFEC90),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          buildSubmitCustom(createChildBloc),
                          GestureDetector(
                            onTap: () {
                              _showModalSheet(null);
                            },
                            child: Container(
                              height: 110,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Color(0xffff5133),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                        "images/premium_tag.svg",
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          width: 320 - 94.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Schedule Mode  📅",
                                                style:
                                                    kBubblegum_sans24.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Specify the Time ⏱️, videos 🎞️, and Channels 📺 for your child",
                                                style:
                                                    kBubblegum_sans16.copyWith(
                                                  color: Color(0xffFFEC90),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          Expanded(
                            flex: 200,
                            child: Transform.translate(
                              offset: Offset(-15, 0),
                              child: SvgPicture.asset(
                                "images/logo-enhanceds.svg",
                                height: 90,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Daily Total Watch Time",
                      style: kBubblegum_sans28.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "images/clock_outlier.svg",
                          height: 400,
                        ),
                        GestureDetector(
                          child: Transform.translate(
                            offset: Offset(0, 13),
                            child: Container(
                              width: 300,
                              child: DurationPicker(
                                duration: _duration,
                                onChange: (val) {
                                  this.setState(() => _duration = val);
                                },
                                snapToMins: 5.0,
                              ),
                            ),
                          ),
                        ),
                        // buildSubmitButton(createChildBloc),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          _currentPage == 0
              ? Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 58.00,
                                width: 226.00,
                                decoration: BoxDecoration(
                                  color: kYellowColor,
                                  borderRadius: BorderRadius.circular(8.00),
                                ),
                              ),
                              Positioned(
                                top: -15,
                                left: 0,
                                child: Transform.scale(
                                  scale: 1.25,
                                  child: SvgPicture.asset(
                                      "images/svgs/mask_button.svg"),
                                ),
                              ),
                              Positioned(
                                left: 226 * 0.35,
                                top: 58 * 0.23,
                                child: Row(
                                  children: [
                                    Text(
                                      "NEXT",
                                      style: kBubblegum_sans32.copyWith(
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            overflow: Overflow.clip,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : _currentPage == 2
                  ? buildSubmitButton(createChildBloc)
                  : Text(""),
        ],
      ),
    );
  }

  Widget buildAgeChips(CreateChildProfileBloc createChildBloc) {
    return StreamBuilder<Object>(
        stream: createChildBloc.age,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Text(
                "Age",
                style: GoogleFonts.bubblegumSans(
                  textStyle: kBubblegum_sans32.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      createChildBloc.changeAge('<4');
                    },
                    child: AgeChip(
                      color: snapshot.data == '<4'
                          ? kYellowColor
                          : Color(0xffff5133),
                      highet: 57.00,
                      width: 80.00,
                      text: "4 or less",
                      // text: " ",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      createChildBloc.changeAge('5-7');
                    },
                    child: AgeChip(
                      color: snapshot.data == "5-7"
                          ? kYellowColor
                          : Color(0xffff5133),
                      highet: 57.00,
                      width: 80.00,
                      text: "5-7",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      createChildBloc.changeAge('8-12');
                    },
                    child: AgeChip(
                      color: snapshot.data == '8-12'
                          ? kYellowColor
                          : Color(0xffff5133),
                      highet: 57.00,
                      width: 80.00,
                      text: "8-12",
                    ),
                  ),
                ],
              )
            ],
          );
        });
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

  Widget buildSubmitButton(CreateChildProfileBloc createChildBloc) {
    return StreamBuilder<Parent>(
        stream: createChildBloc.parentSession,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<bool>(
                initialData: false,
                stream: createChildBloc.validatedStatus,
                builder: (context, validated) {
                  if (!validated.data) {
                    return GestureDetector(
                      onTap: () async {
                        if (!createChildBloc.validateCreateChild()) {
                          return Message(
                                  color: Colors.redAccent,
                                  input: 'Write your Child name !',
                                  context: context)
                              .displayMessage();
                        }
                        _timer.remainSec = _duration.inSeconds;
                        _timer.lengthSec = _duration.inSeconds;
                        _timer.isComplete = false;
                        createChildBloc.changeTimer(_timer);
                        createChildBloc.showProgressBar(true);
                        final child =
                            await createChildBloc.addChild(snapshot.data.id);

                        createChildBloc.showProgressBar(false);
                        Navigator.of(context).pop(context);
                      },
                      child: Transform.translate(
                        offset: Offset(0, -25),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 58.00,
                                width: 226.00,
                                decoration: BoxDecoration(
                                  color: kYellowColor,
                                  borderRadius: BorderRadius.circular(8.00),
                                ),
                              ),
                              Positioned(
                                top: -15,
                                left: 0,
                                child: Transform.scale(
                                  scale: 1.25,
                                  child: SvgPicture.asset(
                                      "images/svgs/mask_button.svg"),
                                ),
                              ),
                              Positioned(
                                left: 226 * 0.35,
                                top: 58 * 0.23,
                                child: Row(
                                  children: [
                                    Text(
                                      "Finsih",
                                      style: kBubblegum_sans32.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            overflow: Overflow.clip,
                          ),
                        ),
                      ),
                    );
                  }
                  return ProgressBar(
                    color: Colors.white,
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }

  Widget buildSubmitCustom(CreateChildProfileBloc createChildBloc) {
    return StreamBuilder<Parent>(
        stream: createChildBloc.parentSession,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<bool>(
              initialData: false,
              stream: createChildBloc.validatedStatus,
              builder: (context, validated) {
                if (!validated.data) {
                  return GestureDetector(
                    onTap: () async {
                      if (!createChildBloc.validateCreateChild()) {
                        return Message(
                                color: Colors.redAccent,
                                input: 'please add a name to your child!',
                                context: context)
                            .displayMessage();
                      }
                      _timer.remainSec = _duration.inSeconds;
                      _timer.lengthSec = _duration.inSeconds;
                      _timer.isComplete = false;
                      createChildBloc.changeTimer(_timer);
                      createChildBloc.showProgressBar(true);
                      createChildBloc.changeAccountType(kAccountype[1]);
                      final child =
                          await createChildBloc.addChild(snapshot.data.id);
                      Logger().i(child.id);
                      createChildBloc.showProgressBar(false);
                      Navigator.pushReplacementNamed(
                          context, kSpecifyVideoSearchChild,
                          arguments: child.id);
                    },
                    child: Container(
                      height: 110,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Color(0xffff5133),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SvgPicture.asset(
                                "images/recommended_tag.svg",
                                height: 30,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: 320 - 94.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Custom Mode  🎞️",
                                        style: kBubblegum_sans24.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "you know what your kids like\nSpesify Viedos for them",
                                        style: kBubblegum_sans16.copyWith(
                                          color: Color(0xffFFEC90),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ProgressBar(
                  color: Colors.white,
                );
              },
            );
          }
          return CircularProgressIndicator();
        });
  }
}
