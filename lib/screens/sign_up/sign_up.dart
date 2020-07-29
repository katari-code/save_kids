import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/screens/sign_in/sign_in.dart';

import 'package:save_kids/util/style.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              color: Colors.black,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('images/logos/appLogo_small.svg'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 40.00,
                          width: 244.00,
                          decoration: BoxDecoration(
                            color: Color(0xff035aa6),
                            borderRadius: BorderRadius.circular(28.00),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: "Sign up",
                                    child: Container(
                                      height: 28.00,
                                      width: 102.00,
                                      decoration: BoxDecoration(
                                        color: Color(0xfffcbf1e),
                                        borderRadius:
                                            BorderRadius.circular(50.00),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Sign up",
                                          style: GoogleFonts.bubblegumSans(
                                              textStyle: kBubblegum_sans2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignIn(),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.bubblegumSans(
                                        textStyle: kBubblegum_sans2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                "Full Name",
                                style: GoogleFonts.capriola(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 51.00,
                              width: 276.00,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.00, 2.00),
                                    color: Color(0xff000000).withOpacity(0.10),
                                    blurRadius: 6,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8.00),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                "Email",
                                style: GoogleFonts.capriola(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 51.00,
                              width: 276.00,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.00, 2.00),
                                    color: Color(0xff000000).withOpacity(0.10),
                                    blurRadius: 6,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8.00),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                "Password",
                                style: GoogleFonts.capriola(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 51.00,
                              width: 276.00,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.00, 2.00),
                                    color: Color(0xff000000).withOpacity(0.10),
                                    blurRadius: 6,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(8.00),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, bottom: 10),
                              child: Text(
                                "Phone number",
                                style: GoogleFonts.capriola(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50.00,
                                  width: 45.00,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 2.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.10),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8.00),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50.03021240234375,
                                  width: 216.79757690429688,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 2.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.10),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8.00),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 58.00,
                              width: 221.00,
                              decoration: BoxDecoration(
                                color: Color(0xfffcbf1e),
                                borderRadius: BorderRadius.circular(84.00),
                              ),
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.bubblegumSans(
                                    textStyle: kBubblegum_sans1.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
