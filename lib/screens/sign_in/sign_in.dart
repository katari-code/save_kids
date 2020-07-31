import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/screens/sign_up/sign_up.dart';
import 'package:save_kids/util/style.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Colors.white,
                  ),
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
                            Hero(
                              tag: "login",
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ),
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.bubblegumSans(
                                    textStyle: kBubblegum_sans20.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 28.00,
                                  width: 102.00,
                                  decoration: BoxDecoration(
                                    color: Color(0xfffcbf1e),
                                    borderRadius: BorderRadius.circular(50.00),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.bubblegumSans(
                                        textStyle: kBubblegum_sans24.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
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
                          Text(
                            "Forget your Password ?",
                            style: GoogleFonts.bubblegumSans(
                              textStyle: TextStyle(
                                fontFamily: "Bubblegum Sans",
                                fontSize: 16,
                                color: Color(0xfffdc402),
                                decoration: TextDecoration.underline,
                              ),
                            ),
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
                                "Sign In",
                                style: GoogleFonts.bubblegumSans(
                                  textStyle: kBubblegum_sans32.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
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
                        ],
                      ),
                    ],
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
