import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/child_avatar.dart';
import 'package:save_kids/screens/account_dashborad_screen/accounts_screen.dart';
import 'package:save_kids/util/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChildScreen extends StatefulWidget {
  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  var childname = " ";
  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
      ),
      backgroundColor: kBlueColor,
      extendBodyBehindAppBar: true,
      body: Consumer<AvatarData>(
        builder: (context, avatarData, child) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.10,
                child: SvgPicture.asset(
                  "images/svgs/Asset1.svg",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    text.translate('Create_a_profile_for_your_kids'),
                    style:
                        GoogleFonts.bubblegumSans(textStyle: kBubblegum_sans32),
                  ),
                  FlatButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext _) => StatefulBuilder(
                        builder: (context, setStaste) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 60,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.yellow[50],
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    avatarData.avatars[avatarData.currentAvatar]
                                        .childAvatar,
                                  ),
                                ),
                                Flexible(
                                  child: GridView.count(
                                    primary: false,
                                    padding: const EdgeInsets.all(20),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    children: List<Widget>.generate(
                                      avatarData.avatars.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          setStaste(
                                            () {
                                              avatarData.setCurrentAvatr(
                                                  avatarData
                                                      .avatars[index].index);
                                            },
                                          );
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 60,
                                              backgroundColor:
                                                  avatarData.currentAvatar ==
                                                          index
                                                      ? kPurpleColor
                                                      : kYellowColor,
                                            ),
                                            Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                backgroundImage: NetworkImage(
                                                  avatarData.avatars[index]
                                                      .childAvatar,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: AgeChip(
                                    color: kBlueDarkColor,
                                    text: "Done",
                                    highet: 60.0,
                                    width: 120.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: NetworkImage(
                        avatarData
                            .avatars[avatarData.currentAvatar].childAvatar,
                      ),
                    ),
                  ),
                  Form(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.12),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Child Name",
                          labelStyle: GoogleFonts.bubblegumSans(
                                  textStyle: kBubblegum_sans28)
                              .copyWith(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          focusColor: Colors.black,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          childname = val;
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        text.translate('Age'),
                        style: GoogleFonts.bubblegumSans(
                            textStyle: kBubblegum_sans32),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                                print(selectedIndex);
                              });
                            },
                            child: AgeChip(
                              color: selectedIndex == 0
                                  ? kPurpleColor
                                  : kBlueDarkColor,
                              highet: 57.00,
                              width: 110.00,
                              text: text.translate('4_or_less'),
                              // text: " ",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                                print(selectedIndex);
                              });
                            },
                            child: AgeChip(
                              color: selectedIndex == 1
                                  ? kPurpleColor
                                  : kBlueDarkColor,
                              highet: 57.00,
                              width: 110.00,
                              text: "5-7",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                                print(selectedIndex);
                              });
                            },
                            child: AgeChip(
                              color: selectedIndex == 2
                                  ? kPurpleColor
                                  : kBlueDarkColor,
                              highet: 57.00,
                              width: 100.00,
                              text: "8-12",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Provider.of<KidsData>(context, listen: false).addKid(
                        Child(
                            Provider.of<AvatarData>(context, listen: false)
                                .avatars[Provider.of<AvatarData>(context,
                                        listen: false)
                                    .currentAvatar]
                                .childAvatar,
                            childname),
                      );

                      await showDialog(
                        context: context,
                        builder: (BuildContext _) => StatefulBuilder(
                          builder: (context, setStaste) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(48),
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: BoxDecoration(
                                color: kRedColor,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                    top: -98,
                                    left: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Transform.scale(
                                      scale: 1.2,
                                      child: SvgPicture.asset(
                                          "images/svgs/mama_and_girls_create.svg"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Get the full experience",
                                        style: kBubblegum_sans24.copyWith(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        " \$ 2.99",
                                        style: kBubblegum_sans44.copyWith(
                                          color: Colors.white,
                                          fontSize: 48,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "+ Schedule the Videos for your kids, \n + Customize the experience for them ",
                                          style: kBubblegum_sans20.copyWith(
                                              color: Colors.white),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            AgeChip(
                                              color: kYellowColor,
                                              text: "Get the app now ",
                                              highet: 60.0,
                                              width: 240.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AgeChip(
                                          color: kBlueDarkColor,
                                          text: "Done",
                                          highet: 60.0,
                                          width: 120.0,
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

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => AccountsDashborasScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Container(
                      height: 58.00,
                      width: 226.00,
                      decoration: BoxDecoration(
                        color: kYellowColor,
                        borderRadius: BorderRadius.circular(50.00),
                      ),
                      child: Center(
                        child: Text(
                          text.translate('Finish'),
                          style: GoogleFonts.bubblegumSans(
                            textStyle: kBubblegum_sans32.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AgeChip extends StatelessWidget {
  const AgeChip({
    this.color,
    this.width,
    this.highet,
    this.text,
  });

  final highet;
  final width;
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: highet,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.00),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.bubblegumSans(
            textStyle: kBubblegum_sans28.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
