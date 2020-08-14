import 'package:flutter/material.dart';
import 'package:save_kids/screens/account_dashborad_screen/accounts_screen.dart';
import 'package:save_kids/screens/child_display_videos/child_display_videos.dart';
import 'package:save_kids/screens/child_display_videos/video_list.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen/video_player_screen.dart';
import 'package:save_kids/screens/create_child_profile/create_child_profile.dart';
import 'package:save_kids/screens/parent_screens/parent_password.dart';
import 'package:save_kids/screens/parent_screens/watch_history_screen/watch_histroy_screen.dart';
import 'package:save_kids/screens/settings_screen/settings_screen.dart';
import 'package:save_kids/screens/specify_screens/add_channel_screen.dart';
import 'package:save_kids/screens/parent_screens/add_schedule.dart';
import 'package:save_kids/screens/parent_screens/parent_dashboard.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/watch_schedule.dart';
import 'package:save_kids/screens/sign_in/sign_in.dart';
import 'package:save_kids/screens/sign_up/sign_up.dart';
import 'package:save_kids/screens/specify_screens/add_videos_screen.dart';
import 'package:save_kids/screens/specify_videos_screen/children_account_screen.dart';
import 'package:save_kids/screens/splash_screen/splash_screen.dart';
import 'package:save_kids/util/constant.dart';

Route<dynamic> createRoute(RouteSettings settings) {
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
    case kParentDashboardRoute:
      return MaterialPageRoute(
        builder: (context) => ParentDashboard(),
      );
    case kAddScheduleRoute:
      return MaterialPageRoute(
        builder: (context) =>
            AddSchedule(settings.arguments, settings.arguments),
      );
    case kSpecifyChannelsRoute:
      return MaterialPageRoute(
        builder: (context) => AddChannelScreen(),
      );
    case kSpecifyVideoRoute:
      return MaterialPageRoute(
        builder: (context) => AddVideoScreen(),
      );
    case kSpecifyVideoChildrenAccount:
      return MaterialPageRoute(
        builder: (context) => ChildrenScreenAccounts(),
      );
    case kWatchSchdeuleRoute:
      return MaterialPageRoute(
        builder: (context) => WatchSchedule(),
      );
    case kParentSettingsRoute:
      return MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      );
    case kParentPinRoute:
      return MaterialPageRoute(
        builder: (context) => ParentPassword(),
      );
    case kAddChildProfileRoute:
      return MaterialPageRoute(
        builder: (context) => AddChildScreen(),
      );
    case kHistoryWatchRoute:
      return MaterialPageRoute(
        builder: (context) => WatchHistory(),
      );
    case kChildAccountRoute:
      return MaterialPageRoute(
        builder: (context) => AccountDashboardScreen(),
      );
    case kVideoDetailsRoute:
      return MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(),
      );
    case kVideoDisplayRoute:
      return MaterialPageRoute(
        builder: (context) => ChildMainViedoList(settings.arguments),
      );
    case kVideoListRoute:
      return MaterialPageRoute(
        builder: (context) => VideoList(),
      );
  }
  return null;
}
