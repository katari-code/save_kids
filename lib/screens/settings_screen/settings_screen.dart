import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/bloc/parent_settings_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/parent.dart';

import '../../components/stream_input_field.dart';
import '../../util/style.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ParentSettingsBloc parentSettingsBloc = ParentSettingsBloc();
  @override
  void dispose() {
    parentSettingsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: Stack(
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
          SafeArea(
            child: Row(
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          "Dashboard",
                          style: kBubblegum_sans40.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                    color: kYellowColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Settings",
                        style: kBubblegum_sans28.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: StreamBuilder<bool>(
              initialData: false,
              stream: parentSettingsBloc.isAuthorised,
              builder: (context, snapshot) {
                if (snapshot.data) {
                  return buildAuthorizedUI(context, parentSettingsBloc);
                }
                return buildUnAuthorizedUI(context, parentSettingsBloc);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUnAuthorizedUI(
      BuildContext context, ParentSettingsBloc parentSettingsBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "Verify To Access Your Account Information",
            style: kBubblegum_sans28,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(25),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: <Widget>[
              StreamReusablefield(
                label: 'Email',
                stream: parentSettingsBloc.signEmail,
                onChangeFunction: parentSettingsBloc.changeEmail,
                type: TextInputType.emailAddress,
              ),
              StreamReusablefield(
                label: 'Password',
                stream: parentSettingsBloc.singPassword,
                onChangeFunction: parentSettingsBloc.changePassword,
                isPass: true,
              ),
              buildSubmitButtons(parentSettingsBloc)
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSubmitButtons(ParentSettingsBloc parentSettingsBloc) {
    return StreamBuilder<bool>(
        stream: parentSettingsBloc.signInStatus,
        initialData: false,
        builder: (context, snapshot) {
          if (!snapshot.data) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    if (parentSettingsBloc.validateSignInFields()) {
                      parentSettingsBloc.showProgressBar(true);
                      final result = await parentSettingsBloc.signIn();
                      parentSettingsBloc.showProgressBar(false);
                      print(result);
                      if (result) {
                        parentSettingsBloc.isAuthorised.add(true);
                      } else {
                        parentSettingsBloc.isAuthorised.add(false);
                        Message(
                                color: Colors.redAccent,
                                input: 'User credentials is not correct',
                                context: context)
                            .displayMessage();
                      }
                    }
                  },
                  child: Container(
                    height: 58.00,
                    width: 221.00,
                    decoration: BoxDecoration(
                      color: Color(0xfffcbf1e),
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Center(
                      child: Text(
                        "Verify",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans32.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    parentSettingsBloc.showProgressBar(true);
                    final result = await parentSettingsBloc.signInWithGoogle();
                    parentSettingsBloc.showProgressBar(false);
                    if (result) {
                      parentSettingsBloc.isAuthorised.add(true);
                    } else {
                      Message(
                              color: Colors.redAccent,
                              input: 'User Not Found',
                              context: context)
                          .displayMessage();
                    }
                  },
                  child: Container(
                    height: 58.00,
                    width: 221.00,
                    decoration: BoxDecoration(
                      color: Color(0xff40BAD5),
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset('images/svgs/googleIcon.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Continue with Google",
                          style: GoogleFonts.bubblegumSans(
                            textStyle: kBubblegum_sans16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return ProgressBar(
            color: kBlueDarkColor,
          );
        });
  }

  Column buildAuthorizedUI(
      BuildContext context, ParentSettingsBloc parentSettingsBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(
          flex: 3,
        ),
        Text(
          "Account Information",
          style: kBubblegum_sans28,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.all(25),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            //settings
            child: StreamBuilder<Parent>(
                stream: parentSettingsBloc.parent,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    parentSettingsBloc.initiateValues(snapshot.data);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamReusablefield(
                          label: 'Full Name',
                          stream: parentSettingsBloc.name,
                          onChangeFunction: parentSettingsBloc.name.add,
                          initialValue: snapshot.data.name,
                          isPass: false,
                        ),
                        StreamReusablefield(
                          label: 'Password',
                          stream: parentSettingsBloc.password,
                          onChangeFunction: parentSettingsBloc.password.add,
                          initialValue: snapshot.data.password,
                          isPass: true,
                        ),
                        StreamReusablefield(
                          label: 'Email',
                          stream: parentSettingsBloc.email,
                          onChangeFunction: parentSettingsBloc.email.add,
                          initialValue: snapshot.data.email,
                          isPass: false,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result =
                                await parentSettingsBloc.updateUser();
                            if (result != null) {
                              Message(
                                      color: Colors.green,
                                      context: context,
                                      input:
                                          'User Credential has been Updated!')
                                  .displayMessage();
                            }
                          },
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
                                child: Text(
                                  "SAVE",
                                  style: GoogleFonts.bubblegumSans(
                                    textStyle: kBubblegum_sans32.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            overflow: Overflow.clip,
                          ),
                        ),
                      ],
                    );
                  }
                  return ProgressBar();
                })),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
