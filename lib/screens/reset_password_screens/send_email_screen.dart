import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/bloc/parent_password_bloc.dart';
import 'package:save_kids/bloc/reset_password_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/stream_input_field.dart';
import 'package:save_kids/util/constant.dart';

import 'package:save_kids/util/style.dart';

class SendEmail extends StatefulWidget {
  @override
  _SendEmailState createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  bool isEmailSent = false;
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
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  //  p
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
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
                          "Account",
                          style: kBubblegum_sans32.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<ResetPasswordBloc>(
            builder: (context, resetPasswordBloc) => StreamBuilder<bool>(
                initialData: false,
                stream: resetPasswordBloc.isSentEmail.value
                    ? resetPasswordBloc.isCodeVerified
                    : resetPasswordBloc.isSentEmail,
                builder: (context, snapshot) {
                  if (isEmailSent) {
                    return buildCodeVerify(context, resetPasswordBloc);
                  } else {
                    return buildEmailVerify(context, resetPasswordBloc);
                  }
                }),
          ),
        ],
      ),
    );
  }

  buildEmailVerify(BuildContext context, ResetPasswordBloc resetPasswordBloc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "images/logos/appLogo_small.svg",
            height: 80,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Verify Your Email",
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
            child: Column(
              children: <Widget>[
                StreamReusablefield(
                  label: 'Email',
                  stream: resetPasswordBloc.emailStream,
                  onChangeFunction: resetPasswordBloc.email.add,
                  isPass: true,
                ),
                StreamBuilder<bool>(
                    stream: resetPasswordBloc.loading,
                    initialData: false,
                    builder: (context, snapshot) {
                      if (!snapshot.data) {
                        return GestureDetector(
                          onTap: () async {
                            final result = resetPasswordBloc.validateEmail();

                            if (result) {
                              resetPasswordBloc.loading.add(true);
                              Future.delayed(Duration(seconds: 5)).then(
                                  (value) =>
                                      resetPasswordBloc.loading.add(false));
                              await resetPasswordBloc.sendEmail;
                              final value = resetPasswordBloc.isSentEmail.value;
                              if (value) {
                                setState(() {
                                  isEmailSent =
                                      resetPasswordBloc.isSentEmail.value;
                                });
                              } else {
                                Message(
                                        color: kRedColor,
                                        context: context,
                                        input:
                                            'Email is incorrect, Please Try Again!')
                                    .displayMessage();
                              }
                            } else {
                              Message(
                                      color: kRedColor,
                                      context: context,
                                      input:
                                          'Email is incorrect, Please Try Again!')
                                  .displayMessage();
                            }
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 58.00,
                                width: 226.00,
                                decoration: BoxDecoration(
                                  color: Color(0xfff6b039),
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
                                  'Verify',
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
                        );
                      }
                      return ProgressBar(color: Colors.white);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildCodeVerify(BuildContext context, ResetPasswordBloc resetPasswordBloc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "images/logos/appLogo_small.svg",
            height: 80,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Enter The Code That You Recieved In Your mail",
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
            child: Column(
              children: <Widget>[
                StreamReusablefield(
                  label: 'Code',
                  stream: resetPasswordBloc.codeStream,
                  onChangeFunction: resetPasswordBloc.code.add,
                  isPass: false,
                  type: TextInputType.number,
                ),
                StreamReusablefield(
                  label: 'New Password',
                  stream: resetPasswordBloc.passwordStream,
                  onChangeFunction: resetPasswordBloc.newPassword.add,
                  isPass: true,
                ),
                StreamBuilder<bool>(
                    initialData: false,
                    stream: resetPasswordBloc.loading,
                    builder: (context, snapshot) {
                      if (!snapshot.data) {
                        return GestureDetector(
                          onTap: () async {
                            final result = resetPasswordBloc.validateFields();

                            if (result) {
                              resetPasswordBloc.loading.add(true);
                              Future.delayed(Duration(seconds: 5)).then(
                                  (value) =>
                                      resetPasswordBloc.loading.add(false));
                              await resetPasswordBloc.verifyCode;
                            } else {
                              Message(
                                      color: kRedColor,
                                      context: context,
                                      input:
                                          'Password and/or Code is incorrect, Please Try Again!')
                                  .displayMessage();
                            }
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 58.00,
                                width: 226.00,
                                decoration: BoxDecoration(
                                  color: Color(0xfff6b039),
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
                                  'Verify',
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
                        );
                      }
                      return ProgressBar(color: Colors.white);
                    }),
                GestureDetector(
                  onTap: () async {
                    resetPasswordBloc.loading.add(true);
                    Future.delayed(Duration(seconds: 5))
                        .then((value) => resetPasswordBloc.loading.add(false));
                    await resetPasswordBloc.sendEmail;
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 58.00,
                        width: 226.00,
                        decoration: BoxDecoration(
                          color: Color(0xfff6b039),
                          borderRadius: BorderRadius.circular(8.00),
                        ),
                      ),
                      Positioned(
                        top: -15,
                        left: 0,
                        child: Transform.scale(
                          scale: 1.25,
                          child:
                              SvgPicture.asset("images/svgs/mask_button.svg"),
                        ),
                      ),
                      Positioned(
                        left: 226 * 0.35,
                        top: 58 * 0.23,
                        child: Text(
                          'Send Email Again',
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
            ),
          )
        ],
      ),
    );
  }
}
