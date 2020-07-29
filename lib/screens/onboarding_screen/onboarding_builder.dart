import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:save_kids/screens/onboarding_screen/onboarding_screen1.dart';
import 'package:save_kids/screens/onboarding_screen/onboarding_screen2.dart';
import 'package:save_kids/screens/onboarding_screen/onboarding_screen3.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:save_kids/screens/onboarding_screen/onboarding_screen4.dart';
import 'package:save_kids/util/style.dart';

class WelcomingView extends StatefulWidget {
  @override
  _WelcomingViewState createState() => _WelcomingViewState();
}

class _WelcomingViewState extends State<WelcomingView> {
  final pageIndexNotifier = ValueNotifier<int>(0);

  List<Widget> welcomeScreens = [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
    OnboardingScreen4(),
  ];

  @override
  Widget build(BuildContext context) {
    int tracker = 0;
    final text = AppLocalizations.of(context);

    return Scaffold(
      body: Stack(
        alignment: FractionalOffset.bottomCenter,
        children: <Widget>[
          PageView.builder(
              onPageChanged: (index) {
                tracker = index;
                pageIndexNotifier.value = tracker;
                print(tracker);
              },
              itemCount: welcomeScreens.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                tracker = index;
                return welcomeScreens[tracker];
              }),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pageIndexNotifier.value;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.arrow_left),
                          Text("Back"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.arrow_right),
                          Text("Sign In"),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildExample1(),
                SizedBox(
                  height: 10,
                ),
                Stack(
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
                        child: SvgPicture.asset("images/svgs/mask_button.svg"),
                      ),
                    ),
                    Positioned(
                      left: 226 * 0.35,
                      top: 58 * 0.23,
                      child: Text(
                        text.translate('NEXT'),
                        style: GoogleFonts.bubblegumSans(
                          textStyle: kBubblegum_sans1.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  overflow: Overflow.clip,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // GestureDetector(
                //   onTap: () {
                //   //   Navigator.pushNamedAndRemoveUntil(
                //   //       context, '/signIn', (_) => false);
                //   // },
                //   child: Text('SKIP',
                //       style: kPrimary_heading_2.copyWith(
                //           color: Colors.grey, fontSize: 15)),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  PageViewIndicator _buildExample1() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      indicatorPadding: const EdgeInsets.all(0),
      length: welcomeScreens.length,
      normalBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInCirc,
        ),
        child: Container(
          width: 20,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kBlueDarkColor,
          ),
        ),
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOutExpo,
        ),
        child: Container(
          width: 25,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: kBlueDarkColor,
          ),
        ),
      ),
    );
  }
}
