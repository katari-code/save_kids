import 'package:flutter/material.dart';
import 'package:save_kids/util/style.dart';

class ModelShown extends StatefulWidget {
  @override
  _ModelShownState createState() => _ModelShownState();
}

class _ModelShownState extends State<ModelShown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Container(
        child: FlatButton(
          child: Text("Hi"),
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    List: [
                                      Color(0xff42D3EE),
                                      Color(0xff44DDE3),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                List: [
                                                  Color(0xfff573c3),
                                                  Color(0xffc13dff),
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "1",
                                                style:
                                                    kBubblegum_sans40.copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Schedule for your kids",
                                                style: kBubblegum_sans20,
                                              ),
                                              Text(
                                                "Schedule for your kids",
                                                style: kCapriola16,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 19,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                List: [
                                                  Color(0xfff573c3),
                                                  Color(0xffc13dff),
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "2",
                                                style:
                                                    kBubblegum_sans40.copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Schedule for your kids",
                                                style: kBubblegum_sans32,
                                              ),
                                              Text(
                                                "data",
                                                style: kCapriola24,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 40,
                            left: 120,
                            child: Container(
                              child: Image.asset(
                                "images/wc_prev.gif",
                                height: 300,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      // body: Image.asset("images/wc_prev.gif"),
    );
  }
}
