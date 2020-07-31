import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/util/style.dart';

import '../../app_localizations.dart';

class ChannelScreen extends StatefulWidget {
  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
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
            Column(
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
                Container(
                  height: 51.00,
                  width: 336.00,
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
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Try Necolidation ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Consumer<ChannelData>(
                    builder: (context, channelData, child) {
                      List<Channel> channels = channelData.channels;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                          itemCount: channels.length,
                          itemBuilder: (context, index) => ChannelCard(
                            channelAvatar: channels[index].channelAvatar,
                            channelDes: channels[index].channelDesc,
                            channelName: channels[index].channelName,
                            isChosen: channels[index].isChose,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
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
                        child: SvgPicture.asset("images/svgs/mask_button.svg"),
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
              ],
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
      margin: EdgeInsets.only(top: 10),
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
          Positioned(
            top: 0,
            left: 0,
            child: Transform.scale(
              scale: 3,
              child: SvgPicture.asset("images/svgs/mask_button.svg"),
            ),
          ),
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
              Row(
                children: <Widget>[],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(channelAvatar),
                      radius: 96 / 3,
                    ),
                    Text(
                      channelName,
                      style: kCapriola20.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
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
