import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_kids/screens/create_child_profile/create_child_profile.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

Future popUpShow(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext _) => StatefulBuilder(
      builder: (context, setStaste) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        child: Container(
          height: 800,
          width: 500,
          decoration: BoxDecoration(
            color: kRedColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " Become premium",
                        style: kBubblegum_sans28.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context, null),
                        child: Image.asset(
                          "images/shape.png",
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Image.asset(
                      "images/watchSchBk.png",
                      height: 250,
                      width: 350,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Get the full experience",
                    style: kBubblegum_sans24.copyWith(color: Colors.white),
                  ),
                  Text(
                    " \$ 2.99",
                    style: kBubblegum_sans44.copyWith(
                      color: Colors.white,
                      fontSize: 38,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "+ Schedule the Videos for your kids, \n + Customize the experience for them \n + cleander view for the whole week",
                      style: kBubblegum_sans16.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AgeChip(
                      color: kBlueDarkColor,
                      text: "Upgrade Now ",
                      highet: 60.0,
                      width: 250.0,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
