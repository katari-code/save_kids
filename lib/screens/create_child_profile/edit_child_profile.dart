import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:save_kids/bloc/edit_child_profile_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/premium_model.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/screens/create_child_profile/widget/time_coursal.dart';
import 'package:save_kids/util/style.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as bloc;

class EditChildScreen extends StatefulWidget {
  final String childId;
  EditChildScreen({this.childId});

  @override
  _EditChildScreenState createState() => _EditChildScreenState();
}

class _EditChildScreenState extends State<EditChildScreen> {
  EditChildProfileBloc editChildBloc = EditChildProfileBloc();
  @override
  void initState() {
    editChildBloc.childId.add(widget.childId);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    editChildBloc.dispose();
    super.dispose();
  }

  Duration _duration = Duration(hours: 0, minutes: 30);
  Timer _timer = new Timer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kBlueColor,
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "images/background.png",
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'images/svgs/Back_video.svg',
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        FlatButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext _) => StatefulBuilder(
                              builder: (context, setStaste) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: StreamBuilder<Object>(
                                      stream: editChildBloc.imageAvatar,
                                      initialData: editChildBloc.avatars[0],
                                      builder: (context, snapshot) {
                                        return Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 15,
                                            ),
                                            CircleAvatar(
                                              backgroundColor: kYellowColor,
                                              radius: 60,
                                              child: CircleAvatar(
                                                radius: 55,
                                                backgroundColor: Colors.white,
                                                backgroundImage:
                                                    NetworkImage(snapshot.data),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Flexible(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                primary: false,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                crossAxisCount: 3,
                                                children: List<Widget>.generate(
                                                  editChildBloc.avatars.length,
                                                  (index) => GestureDetector(
                                                    onTap: () {
                                                      editChildBloc.imageAvatar
                                                          .add(
                                                        editChildBloc
                                                            .avatars[index],
                                                      );
                                                    },
                                                    child: Stack(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 45,
                                                          backgroundColor:
                                                              editChildBloc.avatars[
                                                                          index] ==
                                                                      snapshot
                                                                          .data
                                                                  ? kPurpleColor
                                                                  : kYellowColor,
                                                        ),
                                                        Center(
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 40,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              editChildBloc
                                                                      .avatars[
                                                                  index],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: AgeChip(
                                                color: kBlueDarkColor,
                                                text: "Done",
                                                highet: 60.0,
                                                width: 120.0,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                          child: StreamBuilder<Object>(
                              stream: editChildBloc.imageAvatar,
                              initialData: editChildBloc.avatars[0],
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                  backgroundImage: NetworkImage(snapshot.data),
                                );
                              }),
                        ),
                        buildTextField(context, editChildBloc),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Daily Total Watch Time",
                    style: kBubblegum_sans32,
                  ),
                  // TimeCoursal(
                  //   childBloc: editChildBloc,
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DurationPicker(
                        duration: _duration,
                        onChange: (val) {
                          this.setState(() => _duration = val);
                        },
                        snapToMins: 5.0,
                      )
                    ],
                  ),
                  StreamBuilder<bool>(
                    initialData: false,
                    stream: editChildBloc.validatedStatus,
                    builder: (context, snapshot) {
                      if (!snapshot.data) {
                        return GestureDetector(
                          onTap: () async {
                            await popUpShow(context);
                            //! edit this for payment
                            editChildBloc.showProgressBar(true);
                            _timer.remainSec = _duration.inSeconds;
                            _timer.lengthSec = _duration.inSeconds;
                            _timer.isComplete = false;
                            editChildBloc.changeTimer(_timer);
                            final result = await editChildBloc.setChild();

                            if (result != null) {
                              editChildBloc.showProgressBar(false);
                              Navigator.of(context).pop(context);
                            }
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
                                'Finish',
                                style: GoogleFonts.bubblegumSans(
                                  textStyle: kBubblegum_sans32.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return ProgressBar(
                        color: Colors.white,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // String textInit(EditChildProfileBloc editChildBloc) {
  //   if (editChildBloc.child.value != null) {
  //     return editChildBloc.child.value.name;
  //   }
  //   return '';
  // }

  Widget buildTextField(
      BuildContext context, EditChildProfileBloc editChildBloc) {
    return Container(
      child: StreamBuilder<Object>(
          stream: editChildBloc.childName,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: 200,
                child: TextFormField(
                  initialValue: snapshot.data,
                  decoration: InputDecoration(
                    errorText: snapshot.error,
                    labelText: "Child Name",
                    labelStyle:
                        GoogleFonts.bubblegumSans(textStyle: kBubblegum_sans28)
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
                  onChanged: editChildBloc.changeChildName,
                ),
              );
            }
            return Text('');
          }),
    );
  }

  Widget buildAgeChips(EditChildProfileBloc editChildBloc) {
    return StreamBuilder<Object>(
        stream: editChildBloc.age,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "Age",
                style: GoogleFonts.bubblegumSans(textStyle: kBubblegum_sans32),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      editChildBloc.changeAge('<4');
                    },
                    child: AgeChip(
                      color:
                          snapshot.data == '<4' ? kPurpleColor : kBlueDarkColor,
                      highet: 57.00,
                      width: 110.00,
                      text: "4 or less",
                      // text: " ",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      editChildBloc.changeAge('5-7');
                    },
                    child: AgeChip(
                      color: snapshot.data == "5-7"
                          ? kPurpleColor
                          : kBlueDarkColor,
                      highet: 57.00,
                      width: 110.00,
                      text: "5-7",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      editChildBloc.changeAge('8-12');
                    },
                    child: AgeChip(
                      color: snapshot.data == '8-12'
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
          );
        });
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
