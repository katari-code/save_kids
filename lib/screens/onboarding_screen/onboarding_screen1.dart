import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../app_localizations.dart';

class OnboardingScreen1 extends StatefulWidget {
  @override
  _OnboardingScreen1State createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                // Image.asset('images/onborading1.png'),
                // Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       SvgPicture.asset(
                //         "images/svgs/onboading_screen1_.svg",
                //         fit: BoxFit.cover,
                //       ),
                //       SizedBox(
                //         height: 30,
                //       ),
                //       Text(
                //         "Protect your child",
                //         style: kBubblegum_sans32.copyWith(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Column(
//   children: <Widget>[
//     SizedBox(
//       height: 50,
//     ),
//     Center(
//       child: Column(
//         children: <Widget>[
//           Text(
//             "We know you love your kids 👪",
//             style: GoogleFonts.capriola(
//                 textStyle:
//                     kBubblegum_sans28.copyWith(color: Colors.black)),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 "keeping them ",
//                 style: GoogleFonts.capriola(
//                   textStyle:
//                       kBubblegum_sans28.copyWith(color: Colors.black),
//                 ),
//               ),
//               Text(
//                 " safe ",
//                 style: GoogleFonts.bubblegumSans(
//                   textStyle: kBubblegum_sans32.copyWith(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Text(
//                 "is our priority",
//                 style: GoogleFonts.capriola(
//                   textStyle:
//                       kBubblegum_sans28.copyWith(color: Colors.black),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     ),
//     SizedBox(
//       height: 50,
//     ),
//   ],
// )
