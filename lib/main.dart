import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:save_kids/bloc/account_dashboard_bloc.dart';
import 'package:save_kids/bloc/add_schedule_bloc.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/bloc/channel_bloc.dart';
import 'package:save_kids/bloc/create_child_profile_bloc.dart';
import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/bloc/watch_schedule_bloc.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/child_avatar.dart';

import 'package:provider/provider.dart';
import 'package:save_kids/models/timer.dart';

import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/router.dart';

import 'bloc/add_video_bloc.dart';

import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_up_bloc.dart';

import 'models/schedule_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        ChangeNotifierProvider(
          create: (_) => KidsData(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerData(),
        ),

        // ChangeNotifierProvider(
        //   create: (_) => ChannelData(),
        // ),
      ],
      child: BlocProvider(
        blocs: [
          Bloc((i) => ChannelBloc()),
          Bloc((i) => CreateChildProfileBloc()),
          Bloc((i) => SignUpBloc()),
          Bloc((i) => SignInBloc()),
          Bloc((i) => AccountDashboardBloc()),
          Bloc((i) => AuthBloc()),
          Bloc((i) => VideoListBloc()),
          Bloc((i) => AddVideoBloc()),
          Bloc((i) => AddScheduleBloc()),
          Bloc((i) => WatchScheduleBloc()),
        ],
        child: MaterialApp(
          title: 'Save Video Kids',
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
          initialRoute: kWatchSchdeuleRoute,
          onGenerateRoute: (RouteSettings settings) {
            return createRoute(settings);
          },
          // home: ChildMainViedoList(),
        ),
      ),
    );
  }
}
