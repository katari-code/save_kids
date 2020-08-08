import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.11),
                      blurRadius: 100,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "images/VBackground.png",
                        fit: BoxFit.cover,
                        scale: 1.47,
                      ),
                    ),
                    SvgPicture.asset("images/svgs/Back_video.svg"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
