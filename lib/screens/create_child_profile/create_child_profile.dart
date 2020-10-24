import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/bloc/create_child_profile_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/premium_model.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/util/style.dart';

class AddChildScreen extends StatefulWidget {
  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  CreateChildProfileBloc createChildBloc = CreateChildProfileBloc();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    createChildBloc.dispose();
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
                  Text(
                    "Create a profile for your kids",
                    style: kBubblegum_sans24.copyWith(
                      color: Colors.black,
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
                                      stream: createChildBloc.imageAvatar,
                                      initialData: createChildBloc.avatars[0],
                                      builder: (context, snapshot) {
                                        return Column(
                                          children: <Widget>[
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
                                                  createChildBloc
                                                      .avatars.length,
                                                  (index) => GestureDetector(
                                                    onTap: () {
                                                      createChildBloc
                                                          .changeImageAvatar(
                                                        createChildBloc
                                                            .avatars[index],
                                                      );
                                                    },
                                                    child: Stack(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 45,
                                                          backgroundColor:
                                                              createChildBloc.avatars[
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
                                                              createChildBloc
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
                              stream: createChildBloc.imageAvatar,
                              initialData: createChildBloc.avatars[0],
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                  backgroundImage: NetworkImage(snapshot.data),
                                );
                              }),
                        ),
                        buildTextField(context, createChildBloc),
                      ],
                    ),
                  ),
                  buildAgeChips(createChildBloc),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Daily Total Watch Time",
                    style: kBubblegum_sans32,
                  ),
                  // TimeCoursal(
                  //   childBloc: createChildBloc,
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
                  buildSubmitButton(createChildBloc)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton(CreateChildProfileBloc createChildBloc) {
    return StreamBuilder<Parent>(
        stream: createChildBloc.parentSession,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<bool>(
                initialData: false,
                stream: createChildBloc.validatedStatus,
                builder: (context, validated) {
                  if (!validated.data) {
                    return GestureDetector(
                      onTap: () async {
                        await popUpShow(context);
                        if (!createChildBloc.validateCreateChild()) {
                          return Message(
                                  color: Colors.redAccent,
                                  input: 'please add a name to your child!',
                                  context: context)
                              .displayMessage();
                        }
                        _timer.remainSec = _duration.inSeconds;
                        _timer.lengthSec = _duration.inSeconds;
                        _timer.isComplete = false;
                        createChildBloc.changeTimer(_timer);
                        createChildBloc.showProgressBar(true);
                        final child =
                            await createChildBloc.addChild(snapshot.data.id);

                        createChildBloc.showProgressBar(false);
                        Navigator.of(context).pop(context);
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
                            "Finish",
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
                });
          }
          return CircularProgressIndicator();
        });
  }

  Widget buildTextField(
      BuildContext context, CreateChildProfileBloc createChildBloc) {
    return Container(
      child: StreamBuilder<Object>(
          stream: createChildBloc.childName,
          builder: (context, snapshot) {
            return SizedBox(
              width: 190,
              child: TextFormField(
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
                onChanged: createChildBloc.changeChildName,
              ),
            );
          }),
    );
  }

  Widget buildAgeChips(CreateChildProfileBloc createChildBloc) {
    return StreamBuilder<Object>(
        stream: createChildBloc.age,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
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
                      createChildBloc.changeAge('<4');
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
                      createChildBloc.changeAge('5-7');
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
                      createChildBloc.changeAge('8-12');
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
            textStyle: kBubblegum_sans24.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
