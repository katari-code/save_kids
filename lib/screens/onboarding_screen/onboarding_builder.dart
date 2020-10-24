import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? kRedColor : kRedColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/BKonborading.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: 600.0,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Container(
                            child: Stack(
                              children: [
                                Image(
                                  image: AssetImage(
                                    'images/onborading1.png',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                                Positioned(
                                  top: 40,
                                  left: 40,
                                  child: SvgPicture.asset(
                                    "images/svgs/onboading_screen1_.svg",
                                    height: 200,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'Protect your child',
                          style: kBubblegum_sans40.copyWith(
                            color: kRedColor,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'We know you love your kids Keeping them safe is our priority',
                            style: kCapriola20.copyWith(color: kBlueDarkColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Container(
                              child: Stack(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'images/onborading2.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 40,
                                    child: SvgPicture.asset(
                                      "images/svgs/onboading_screen2_.svg",
                                      width: 200,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'Chose categories',
                            textAlign: TextAlign.center,
                            style: kBubblegum_sans40.copyWith(
                              color: kRedColor,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Choose from many categories of fun and family friendly content',
                            style: kCapriola20.copyWith(color: kBlueDarkColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Container(
                              child: Stack(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      'images/onborading4.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                  Positioned(
                                    top: 50,
                                    left: 60,
                                    child: Image.asset(
                                      "images/onboading_screen3_.png",
                                      width: 150,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            'Set the Time Limit',
                            textAlign: TextAlign.center,
                            style: kBubblegum_sans40.copyWith(
                              color: kRedColor,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Set watch time limits and monitor your \n childs's watch history",
                            style: kCapriola20.copyWith(color: kBlueDarkColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _currentPage != _numPages - 1
                        ? Align(
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
                                          borderRadius:
                                              BorderRadius.circular(8.00),
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
                          )
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                _pageController.previousPage(
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
                                          borderRadius:
                                              BorderRadius.circular(8.00),
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
                                        left: 226 * 0.25,
                                        top: 58 * 0.23,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "BACK",
                                              style: kBubblegum_sans32.copyWith(
                                                  color: Colors.white),
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
                  ],
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color: kYellowColor,
                    ),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, kSignInRoute),
                      child: Text(
                        'Sign In',
                        style: kBubblegum_sans28.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
