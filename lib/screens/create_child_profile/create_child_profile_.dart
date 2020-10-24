// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_duration_picker/flutter_duration_picker.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:logger/logger.dart';
// import 'package:save_kids/bloc/create_child_profile_bloc.dart';
// import 'package:save_kids/components/control_widgets/message.dart';
// import 'package:save_kids/components/control_widgets/progress_bar.dart';
// import 'package:save_kids/components/stream_input_field.dart';
// import 'package:save_kids/models/parent.dart';
// import 'package:save_kids/models/timer.dart';
// import 'package:save_kids/screens/show_models/commercial_dialogue.dart';
// import 'package:save_kids/util/constant.dart';
// import 'package:save_kids/util/style.dart';
// import 'package:toggle_switch/toggle_switch.dart';

// import 'create_child_profile.dart';

// class CreateChildwalkthrough extends StatefulWidget {
//   @override
//   _CreateChildwalkthroughState createState() => _CreateChildwalkthroughState();
// }

// class _CreateChildwalkthroughState extends State<CreateChildwalkthrough> {
//   int _numPages = 3;
//   final PageController _pageController = PageController(initialPage: 0);
//   Duration _duration = Duration(hours: 0, minutes: 30);
//   Timer _timer = new Timer();
//   CreateChildProfileBloc createChildBloc = CreateChildProfileBloc();

//   int _currentPage = 0;
//   int _toggleIndex = 0;

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 8.0,
//       width: isActive ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isActive ? kRedColor : kRedColor,
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> _buildPageIndicator() {
//       List<Widget> list = [];
//       for (int i = 0; i < _numPages; i++) {
//         list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//       }
//       return list;
//     }

//     return Scaffold(
//       backgroundColor: kBlueColor,
//       resizeToAvoidBottomInset: false,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Opacity(
//                 opacity: 0.2,
//                 child: Image.asset(
//                   "images/background.png",
//                   repeat: ImageRepeat.repeat,
//                 ),
//               ),
//             ),
//             Container(
//               height: 600.0,
//               child: PageView(
//                 physics: NeverScrollableScrollPhysics(),
//                 controller: _pageController,
//                 onPageChanged: (int page) {
//                   setState(() {
//                     _currentPage = page;
//                   });
//                 },
//                 children: <Widget>[
//                   SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 50.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           FlatButton(
//                             onPressed: () => showDialog(
//                               context: context,
//                               builder: (BuildContext _) => StatefulBuilder(
//                                 builder: (context, setStaste) => Dialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height,
//                                     width: MediaQuery.of(context).size.width,
//                                     child: StreamBuilder<Object>(
//                                         stream: createChildBloc.imageAvatar,
//                                         initialData: createChildBloc.avatars[0],
//                                         builder: (context, snapshot) {
//                                           return Column(
//                                             children: <Widget>[
//                                               CircleAvatar(
//                                                 backgroundColor: kYellowColor,
//                                                 radius: 60,
//                                                 child: CircleAvatar(
//                                                   radius: 55,
//                                                   backgroundColor: Colors.white,
//                                                   backgroundImage: NetworkImage(
//                                                     snapshot.data,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Flexible(
//                                                 child: GridView.count(
//                                                   shrinkWrap: true,
//                                                   primary: false,
//                                                   padding:
//                                                       const EdgeInsets.all(20),
//                                                   crossAxisSpacing: 10,
//                                                   mainAxisSpacing: 10,
//                                                   crossAxisCount: 3,
//                                                   children:
//                                                       List<Widget>.generate(
//                                                     createChildBloc
//                                                         .avatars.length,
//                                                     (index) => GestureDetector(
//                                                       onTap: () {
//                                                         createChildBloc
//                                                             .changeImageAvatar(
//                                                           createChildBloc
//                                                               .avatars[index],
//                                                         );
//                                                       },
//                                                       child: Stack(
//                                                         children: <Widget>[
//                                                           CircleAvatar(
//                                                             radius: 45,
//                                                             backgroundColor: createChildBloc
//                                                                             .avatars[
//                                                                         index] ==
//                                                                     snapshot
//                                                                         .data
//                                                                 ? kPurpleColor
//                                                                 : kYellowColor,
//                                                           ),
//                                                           Center(
//                                                             child: CircleAvatar(
//                                                               backgroundColor:
//                                                                   Colors.white,
//                                                               radius: 40,
//                                                               backgroundImage:
//                                                                   NetworkImage(
//                                                                 createChildBloc
//                                                                         .avatars[
//                                                                     index],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 25,
//                                               ),
//                                               GestureDetector(
//                                                 onTap: () =>
//                                                     Navigator.pop(context),
//                                                 child: AgeChip(
//                                                   color: kBlueDarkColor,
//                                                   text: "Done",
//                                                   highet: 60.0,
//                                                   width: 120.0,
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         }),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             child: StreamBuilder<Object>(
//                                 stream: createChildBloc.imageAvatar,
//                                 initialData: createChildBloc.avatars[0],
//                                 builder: (context, snapshot) {
//                                   return Stack(
//                                     alignment: Alignment.bottomRight,
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: Colors.yellow,
//                                         radius: 55,
//                                         child: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           radius: 50,
//                                           backgroundImage:
//                                               NetworkImage(snapshot.data),
//                                         ),
//                                       ),
//                                       CircleAvatar(
//                                         backgroundColor: Colors.white,
//                                         child: Icon(
//                                           Icons.edit,
//                                           color: Colors.yellow,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           StreamReusablefield(
//                             stream: createChildBloc.childName,
//                             label: 'Child name',
//                             onChangeFunction: createChildBloc.changeChildName,
//                             isPass: false,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ToggleSwitch(
//                         minWidth: 100.0,
//                         initialLabelIndex: _toggleIndex,
//                         cornerRadius: 20.0,
//                         activeFgColor: Colors.white,
//                         inactiveBgColor: Colors.grey,
//                         inactiveFgColor: Colors.white,
//                         labels: ['Explore 🚀', 'Custom 🎞️', 'schedule 📅'],
//                         activeBgColors: [
//                           Colors.blue,
//                           Colors.pink,
//                           Colors.purple
//                         ],
//                         onToggle: (index) async {
//                           index == 2 ? _showModalSheet() : _toggleIndex = index;
//                           index == 0 ? _numPages = 3 : _numPages = 2;

//                           setState(() {});
//                           Logger().i(_toggleIndex);
//                           await createChildBloc
//                               .changeAccountType(kAccountype[index]);
//                         },
//                       ),
//                       SizedBox(
//                         height: 18,
//                       ),
//                       _toggleIndex == 0
//                           ? Container(
//                               width: 300,
//                               height: 320,
//                               padding: EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                 color: kPurpleColor,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(4),
//                                 ),
//                               ),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 15,
//                                   ),
//                                   Text(
//                                     "Let your childern have fun with five different Categories for a specific time of the day",
//                                     textAlign: TextAlign.center,
//                                     style: kBubblegum_sans20.copyWith(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Wrap(
//                                     alignment: WrapAlignment.center,
//                                     children: List.generate(
//                                       kIconLink.length,
//                                       (index) => Container(
//                                         width: 75,
//                                         child: Image.network(kIconLink[index]),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : _toggleIndex == 1
//                               ? Container(
//                                   child: Container(
//                                     width: 300,
//                                     height: 320,
//                                     padding: EdgeInsets.all(15),
//                                     decoration: BoxDecoration(
//                                       color: kPurpleColor,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(4),
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         SizedBox(
//                                           height: 15,
//                                         ),
//                                         Text(
//                                           "Customize your child experiences \n choose specific videos  for your child",
//                                           textAlign: TextAlign.center,
//                                           style: kBubblegum_sans20.copyWith(
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             SvgPicture.asset(
//                                               'images/svgs/videosicon.svg',
//                                               height: 50,
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Container(
//                                               child: Image.asset(
//                                                 "images/coustom.png",
//                                                 height: 150,
//                                               ),
//                                             )
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   width: 300,
//                                   height: 320,
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: kPurpleColor,
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(4),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//                                       Text(
//                                         "Let your childern have fun with five different Categories for a specific time of the day",
//                                         textAlign: TextAlign.center,
//                                         style: kBubblegum_sans20.copyWith(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 20,
//                                       ),
//                                       Wrap(
//                                         alignment: WrapAlignment.center,
//                                         children: List.generate(
//                                           kIconLink.length,
//                                           (index) => Container(
//                                             width: 75,
//                                             child:
//                                                 Image.network(kIconLink[index]),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "Daily Total Watch Time",
//                         style: kBubblegum_sans32,
//                       ),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       GestureDetector(
//                           child: Container(
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         child: DurationPicker(
//                           duration: _duration,
//                           onChange: (val) {
//                             this.setState(() => _duration = val);
//                           },
//                           snapToMins: 5.0,
//                         ),
//                       ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(60.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: _buildPageIndicator(),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   _currentPage != _numPages - 1
//                       ? Align(
//                           alignment: Alignment.bottomCenter,
//                           child: FlatButton(
//                             padding: EdgeInsets.all(0),
//                             onPressed: () {
//                               _pageController.nextPage(
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease,
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Stack(
//                                   children: <Widget>[
//                                     Container(
//                                       height: 58.00,
//                                       width: 226.00,
//                                       decoration: BoxDecoration(
//                                         color: kYellowColor,
//                                         borderRadius:
//                                             BorderRadius.circular(8.00),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       top: -15,
//                                       left: 0,
//                                       child: Transform.scale(
//                                         scale: 1.25,
//                                         child: SvgPicture.asset(
//                                             "images/svgs/mask_button.svg"),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       left: 226 * 0.35,
//                                       top: 58 * 0.23,
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             "NEXT",
//                                             style: kBubblegum_sans32.copyWith(
//                                                 color: Colors.white),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Icon(
//                                             Icons.arrow_forward,
//                                             color: Colors.white,
//                                             size: 30.0,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                   overflow: Overflow.clip,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : buildSubmitButton(createChildBloc),
//                 ],
//               ),
//             ),
//             SafeArea(
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   height: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _currentPage != 0
//                           ? GestureDetector(
//                               onTap: () {
//                                 _pageController.previousPage(
//                                   duration: Duration(milliseconds: 500),
//                                   curve: Curves.ease,
//                                 );
//                               },
//                               child: Container(
//                                 child: Icon(
//                                   Icons.arrow_back,
//                                   size: 30,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             )
//                           : Text(""),
//                       Text(
//                         _currentPage == 1
//                             ? "2.Choose the profile mode"
//                             : _currentPage == 2
//                                 ? "Last Step ..              "
//                                 : "1.Create new child Profile",
//                         style: kBubblegum_sans28.copyWith(
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showModalSheet() {
//     showModalBottomSheet(
//       enableDrag: true,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(35),
//           topRight: Radius.circular(35),
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (builder) => CommercialDialogue(),
//     );
//   }

//   Widget buildSubmitButton(CreateChildProfileBloc createChildBloc) {
//     return StreamBuilder<Parent>(
//         stream: createChildBloc.parentSession,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return StreamBuilder<bool>(
//                 initialData: false,
//                 stream: createChildBloc.validatedStatus,
//                 builder: (context, validated) {
//                   if (!validated.data) {
//                     return GestureDetector(
//                       onTap: () async {
//                         if (!createChildBloc.validateCreateChild()) {
//                           return Message(
//                                   color: Colors.redAccent,
//                                   input: 'please add a name to your child!',
//                                   context: context)
//                               .displayMessage();
//                         }
//                         _timer.remainSec = _duration.inSeconds;
//                         _timer.lengthSec = _duration.inSeconds;
//                         _timer.isComplete = false;
//                         createChildBloc.changeTimer(_timer);
//                         createChildBloc.showProgressBar(true);
//                         final child =
//                             await createChildBloc.addChild(snapshot.data.id);

//                         createChildBloc.showProgressBar(false);
//                         Navigator.of(context).pop(context);
//                       },
//                       child: Align(
//                         child: Stack(
//                           children: <Widget>[
//                             Container(
//                               height: 58.00,
//                               width: 226.00,
//                               decoration: BoxDecoration(
//                                 color: kYellowColor,
//                                 borderRadius: BorderRadius.circular(8.00),
//                               ),
//                             ),
//                             Positioned(
//                               top: -15,
//                               left: 0,
//                               child: Transform.scale(
//                                 scale: 1.25,
//                                 child: SvgPicture.asset(
//                                     "images/svgs/mask_button.svg"),
//                               ),
//                             ),
//                             Positioned(
//                               left: 226 * 0.35,
//                               top: 58 * 0.23,
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     "Finsih",
//                                     style: kBubblegum_sans32.copyWith(
//                                         color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                           overflow: Overflow.clip,
//                         ),
//                       ),
//                     );
//                   }
//                   return ProgressBar(
//                     color: Colors.white,
//                   );
//                 });
//           }
//           return CircularProgressIndicator();
//         });
//   }
// }
