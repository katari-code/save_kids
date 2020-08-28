import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
import 'package:save_kids/bloc/channel_bloc.dart';
// import 'package:provider/provider.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../app_localizations.dart';

class AddChannelScreen extends StatefulWidget {
  @override
  _AddChannelScreenState createState() => _AddChannelScreenState();
}

class _AddChannelScreenState extends State<AddChannelScreen> {
  ScrollController _scrollController = ScrollController();
  ChannelBloc channelBloc = BlocProvider.getBloc<ChannelBloc>();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        channelBloc.getChannelBySearch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    channelBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.10,
              child: SvgPicture.asset(
                "images/svgs/Asset1.svg",
                color: Colors.black,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Channels",
                        style: kBubblegum_sans40.copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset("images/svgs/channel.svg"),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 51.00,
                        width: 250.00,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 2.00),
                              color: Color(0xff000000).withOpacity(0.10),
                              blurRadius: 6,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.00),
                        ),
                        child: StreamBuilder<Object>(
                          stream: channelBloc.searchResult,
                          builder: (context, snapshot) {
                            return TextField(
                              onChanged: channelBloc.changeSearchResult,
                              // onSubmitted: ,
                              decoration: InputDecoration(
                                errorText: snapshot.error,
                                prefixIcon: GestureDetector(
                                  onTap: () => channelBloc.getChannelBySearch(),
                                  child: Icon(Icons.search),
                                ),
                                hintText: "Try music for kids ",
                                border: InputBorder.none,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 55,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 2.00),
                              color: Color(0xff000000).withOpacity(0.10),
                              blurRadius: 6,
                            )
                          ],
                          color: kYellowColor,
                        ),
                        child: FlatButton(
                          onPressed: () {
                            channelBloc.changeChannelList([]);
                            channelBloc.getChannelBySearch();
                          },
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<Object>(
                    stream: channelBloc.channels,
                    builder: (context, snapshot) {
                      List<Channel> channels = snapshot.data ?? [];
                      return Container(
                        height:
                            MediaQuery.of(context).size.height * 0.80 / 1.75,
                        width: 336.00,
                        child: ListView.builder(
                          itemCount: channels.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) => CustomAnimation(
                            duration: Duration(milliseconds: 600),
                            delay: Duration(
                              milliseconds: (500 * 2).round(),
                            ),
                            curve: Curves.elasticOut,
                            tween: Tween<double>(
                              begin: 0,
                              end: 1,
                            ),
                            builder: (context, child, value) => Transform.scale(
                              scale: value,
                              child: GestureDetector(
                                onTap: () => channelBloc
                                    .addChosenChannel(channels[index].id),
                                child: ChannelCard(
                                  channelAvatar:
                                      channels[index].profilePictureUrl,
                                  channelDes: channels[index].description,
                                  channelName: channels[index].title,
                                  isChosen: channels[index].chosen,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(
                        context, channelBloc.returnChosenChannels()),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 58.00,
                          width: 226.00,
                          decoration: BoxDecoration(
                            color: Color(0xfff6b039),
                            borderRadius: BorderRadius.circular(8.00),
                          ),
                        ),
                        Positioned(
                          top: -15,
                          left: 0,
                          child: Transform.scale(
                            scale: 1.25,
                            child:
                                SvgPicture.asset("images/svgs/mask_button.svg"),
                          ),
                        ),
                        Positioned(
                          left: 226 * 0.35,
                          top: 58 * 0.23,
                          child: Text(
                            text.translate('Done'),
                            style: GoogleFonts.bubblegumSans(
                              textStyle: kBubblegum_sans32.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                      overflow: Overflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChannelCard extends StatelessWidget {
  ChannelCard({
    this.channelName,
    this.channelAvatar,
    this.channelDes,
    this.isChosen,
  });

  final channelName;
  final channelAvatar;
  final channelDes;
  final isChosen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105.00,
      width: 336.00,
      margin: EdgeInsets.only(
        top: 10,
      ),
      decoration: BoxDecoration(
        color: kRedColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(4.00),
      ),
      child: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Transform.scale(
          //     scale: 2,
          //     child: SvgPicture.asset("images/svgs/mask_button.svg"),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 105.00,
              width: 10.00,
              decoration: BoxDecoration(
                color:
                    isChosen ? kChannelSelectedColor : kChannelUnSelectedColor,
                borderRadius: BorderRadius.circular(4.00),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10, top: 10),
                child: Container(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(channelAvatar),
                        radius: 96 / 3,
                      ),
                      Text(
                        channelName.length > 12
                            ? channelName.substring(0, 12)
                            : channelName,
                        style: kCapriola20.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  channelDes,
                  style:
                      kCapriola20.copyWith(fontSize: 14, color: Colors.white),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
