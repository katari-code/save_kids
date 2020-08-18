import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:save_kids/bloc/account_dashboard_bloc.dart';
import 'package:save_kids/bloc/add_schedule_bloc.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/bloc/channel_bloc.dart';
import 'package:save_kids/bloc/child_video_list_bloc.dart';
import 'package:save_kids/bloc/create_child_profile_bloc.dart';
import 'package:save_kids/bloc/parent_dashboard_bloc.dart';
import 'package:save_kids/bloc/parent_password_bloc.dart';
import 'package:save_kids/bloc/parent_settings_bloc.dart';
import 'package:save_kids/bloc/specify_add_video_bloc.dart';
import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/bloc/watch_history_bloc.dart';
import 'package:save_kids/bloc/watch_schedule_bloc.dart';
import 'package:save_kids/models/child_avatar.dart';

import 'package:provider/provider.dart';

import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/preference/prefs_singleton.dart';
import 'package:save_kids/util/router.dart';

import 'bloc/add_video_bloc.dart';

import 'bloc/kids_accounts_specify_video_bloc.dart';
import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_up_bloc.dart';

import 'models/schedule_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AvatarData(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleData(),
        ),
      ],
      child: BlocProvider(
        blocs: [
          Bloc((i) => ChannelBloc()),
          Bloc((i) => CreateChildProfileBloc()),
          Bloc((i) => SignUpBloc()),
          Bloc((i) => SignInBloc()),
          Bloc((i) => AccountDashboardBloc()),
          Bloc((i) => ParentDashBoardBloc()),
          Bloc((i) => ParentSettingsBloc()),
          Bloc((i) => ParentPasswordBloc()),
          Bloc((i) => AuthBloc()),
          Bloc((i) => VideoListBloc()),
          Bloc((i) => AddVideoBloc()),
          Bloc((i) => AddScheduleBloc()),
          Bloc((i) => WatchScheduleBloc()),
          Bloc((i) => ChildVideoListBloc()),
          Bloc((i) => WatchHistoryBloc()),
          Bloc((i) => KidsAccountsSpecifyVideosBloc()),
          Bloc((i) => SpecifyAddVideoBloc())
        ],
        child: MaterialApp(
          title: 'Safe Video Kids',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          supportedLocales: [
            Locale('en', 'US'),
            Locale('de', 'DE'),
          ],
          localizationsDelegates: [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }

            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },
          initialRoute: kSplashRoute,
          onGenerateRoute: (RouteSettings settings) {
            return createRoute(settings);
          },
          // home: ChildMainViedoList(),
        ),
      ),
    );
  }
}
