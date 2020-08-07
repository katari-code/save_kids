import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoCard extends StatelessWidget {
  final String image;
  final String videoTitle;
  final String description;

  VideoCard(this.image, this.videoTitle, this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        // image: DecorationImage(image: Netw),
        color: Color(0xFF502F5F),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(
            image,
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              videoTitle,
              style: GoogleFonts.capriola(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
