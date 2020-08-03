import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:save_kids/bloc/channel_bloc.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/child_avatar.dart';

import 'package:provider/provider.dart';
import 'package:save_kids/screens/parent_screens/watch_schedule/watch_schedule.dart';

import 'bloc/developer_blocs/add_channel_bloc.dart';
import 'bloc/sign_in_bloc.dart';
import 'bloc/sign_up_bloc.dart';

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
          create: (_) => KidsData(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => ChannelData(),
        // ),
      ],
      child: BlocProvider(
        blocs: [
          Bloc((i) => ChannelBloc()),
          Bloc((i) => AddChannelBloc()),
          Bloc((i) => SignUpBloc()),
          Bloc((i) => SignInBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
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
          home: WatchSchedule(),
        ),
      ),
    );
  }
}
