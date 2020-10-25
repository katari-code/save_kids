import 'package:flutter/material.dart';
import 'package:save_kids/bloc/edit_child_profile_bloc.dart';
import 'package:save_kids/screens/account_dashborad_screen/accounts_screen.dart';
import 'package:save_kids/screens/child_display_videos/child_display_videos.dart';
import 'package:save_kids/screens/child_display_videos/child_display_videos_specfiy.dart';
import 'package:save_kids/screens/child_display_videos/child_display_videos_watch_sche.dart';
import 'package:save_kids/screens/child_display_videos/video_list.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen/video_player_screen.dart';
import 'package:save_kids/screens/create_child_profile/create_child_profile.dart';
import 'package:save_kids/screens/create_child_profile/create_child_profile_1.dart';
import 'package:save_kids/screens/create_child_profile/edit_child_profile.dart';
import 'package:save_kids/screens/onboarding_screen/onboarding_builder.dart';
import 'package:save_kids/screens/parent_screens/parent_password.dart';
import 'package:save_kids/screens/parent_screens/watch_history_screen/watch_histroy_screen.dart';
import 'package:save_kids/screens/reset_password_screens/send_email_screen.dart';
import 'package:save_kids/screens/settings_screen/settings_screen.dart';
import 'package:save_kids/screens/specify_screens/add_channel_screen.dart';
import 'package:save_kids/screens/parent_screens/add_schedule.dart';
import 'package:save_kids/screens/parent_screens/parent_dashboard.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/watch_schedule.dart';
import 'package:save_kids/screens/sign_in/sign_in.dart';
import 'package:save_kids/screens/sign_up/sign_up.dart';
import 'package:save_kids/screens/specify_screens/add_videos_screen.dart';
import 'package:save_kids/screens/specify_videos_screen/children_account_screen.dart';
import 'package:save_kids/screens/specify_videos_screen/specify_viedo_screen.dart';
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
      break;
    case kOnboradingScreen:
      return MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      );
      break;
    case kSignInRoute:
      return MaterialPageRoute(
        builder: (context) => SignIn(),
      );
      break;
    case kResetPasswordRoute:
      return MaterialPageRoute(
        builder: (context) => SendEmail(),
      );
      break;
    case kSginUpRoute:
      return MaterialPageRoute(
        builder: (context) => SignUp(),
      );
      break;
    case kParentDashboardRoute:
      return MaterialPageRoute(
        builder: (context) => ParentDashboard(),
      );
      break;
    case kAddScheduleRoute:
      return MaterialPageRoute(
        builder: (context) =>
            AddSchedule(settings.arguments, settings.arguments),
      );
      break;
    case kSpecifyChannelsRoute:
      return MaterialPageRoute(
        builder: (context) => AddChannelScreen(),
      );
      break;
    case kSpecifyVideoRoute:
      return MaterialPageRoute(
        builder: (context) => AddVideoScreen(),
      );
      break;
    case kSpecifyVideoChildrenAccount:
      return MaterialPageRoute(
        builder: (context) => ChildrenScreenAccounts(),
      );
      break;
    case kWatchSchdeuleRoute:
      return MaterialPageRoute(
        builder: (context) => WatchSchedule(),
      );
      break;
    case kParentSettingsRoute:
      return MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      );
      break;
    case kParentPinRoute:
      return MaterialPageRoute(
        builder: (context) => ParentPassword(),
      );
      break;
    case kAddChildProfileRoute:
      return MaterialPageRoute(
        builder: (context) => WalkthroghProfile(),
      );
      break;
    case kChildEditProfileRoute:
      return MaterialPageRoute(
        builder: (context) => EditChildScreen(
          childId: settings.arguments,
        ),
      );
      break;
    case kHistoryWatchRoute:
      return MaterialPageRoute(
        builder: (context) => WatchHistory(),
      );
      break;
    case kChildAccountRoute:
      return MaterialPageRoute(
        builder: (context) => AccountDashboardScreen(),
      );
      break;
    case kVideoDetailsRoute:
      return MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(),
      );
      break;
    case kVideoDisplayRoute:
      return MaterialPageRoute(
        builder: (context) => ChildMainViedoList(settings.arguments),
      );
      break;
    case kVideoDisplayRoute:
      return MaterialPageRoute(
        builder: (context) => ChildMainViedoList(settings.arguments),
      );
      break;
    case kVideoDisplaySpecifyRoute:
      return MaterialPageRoute(
        builder: (context) => ChildMainViedoListSpecify(settings.arguments),
      );
      break;
    case kVideoListRoute:
      return MaterialPageRoute(
        builder: (context) => VideoList(),
      );
      break;
    case kSpecifyVideoSearchChild:
      return MaterialPageRoute(
        builder: (context) => SpecifyVideoScreen(
          childID: settings.arguments,
        ),
      );
      break;
    case kChildMainViedoListWatchSchedule:
      return MaterialPageRoute(
        builder: (context) => ChildMainViedoListWatchSchedule(
          schedule: settings.arguments,
        ),
      );
      break;
  }
  return null;
}
