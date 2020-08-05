import 'package:flutter/material.dart';
import 'package:save_kids/screens/channel_screen/channel_screen.dart';
import 'package:save_kids/screens/child_screen/create_child_profile.dart';
import 'package:save_kids/screens/parent_screens/add_schedule.dart';
import 'package:save_kids/screens/parent_screens/parent_dashboard.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/watch_schedule.dart';
import 'package:save_kids/screens/sign_in/sign_in.dart';
import 'package:save_kids/screens/sign_up/sign_up.dart';
import 'package:save_kids/screens/splash_screen/splash_screen.dart';
import 'package:save_kids/screens/wrapper_screen/wrapper_screen.dart';
import 'package:save_kids/util/constant.dart';

Route<dynamic> createRoute(settings) {
  // settings.arguments
  switch (settings.name) {
    case kHomeRoute:
    case kSplashRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kSignInRoute:
      return MaterialPageRoute(
        builder: (context) => SignIn(),
      );
    case kSginUpRoute:
      return MaterialPageRoute(
        builder: (context) => SignUp(),
      );
    case kWrapperRoute:
      return MaterialPageRoute(
        builder: (context) => Wrapper(),
      );

    case kParentDashboardRoute:
      return MaterialPageRoute(
        builder: (context) => ParentDashboard(),
      );
    case kAddScheduleRoute:
      return MaterialPageRoute(
        builder: (context) => AddSchedule(),
      );

    // case kParentDashboardRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => PA(),
    //   );

    case kSpecifyChannelsRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kSpecifyVideoRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kAddChannelRoute:
      return MaterialPageRoute(
        builder: (context) => AddChannelScreen(),
      );
    case kWatchSchdeuleRoute:
      return MaterialPageRoute(
        builder: (context) => WatchSchedule(),
      );
    case kHistoryRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kParentSettingsRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kAddChildProfileRoute:
      return MaterialPageRoute(
        builder: (context) => AddChildScreen(),
      );

    // case kParentPinRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => SpalschScreen(),
    //   );

    case kChildAccountRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kVideoListRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
    case kVideoDetailsRoute:
      return MaterialPageRoute(
        builder: (context) => SpalschScreen(),
      );
  }
  return null;
}