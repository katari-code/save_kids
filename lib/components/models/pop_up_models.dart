import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_kids/util/style.dart';

Future BlockedModel(BuildContext context, Function hideFunction) {
  return showDialog(
    context: context,
    builder: (BuildContext _) => StatefulBuilder(
      builder: (context, setStaste) => Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: 300,
          decoration: BoxDecoration(
            color: kBlueDarkColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: 300,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hide inappropriate video ",
                    textAlign: TextAlign.center,
                    style: kBubblegum_sans28.copyWith(color: Colors.white),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.video_library,
                        color: Colors.red,
                        size: 40,
                      ),
                      Icon(
                        Icons.block,
                        color: Colors.white,
                        size: 60,
                      ),
                    ],
                  ),

                  // SvgPicture.asset(
                  //   'images/svgs/girls_popup.svg',
                  //   height: 145,
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: hideFunction,
                        child: Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            color: kRedColor,
                            borderRadius: BorderRadius.circular(20.00),
                          ),
                          child: Center(
                            child: Text(
                              "Block video",
                              style: kBubblegum_sans20.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.pop(context, null),
                        },
                        child: Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xffC1C1C1),
                            borderRadius: BorderRadius.circular(20.00),
                          ),
                          child: Center(
                            child: Text(
                              "Cancle ",
                              style: kBubblegum_sans20.copyWith(
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
            ],
          ),
        ),
      ),
    ),
  );
}
