// Copyright 2018, Devoxx
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/blocs/app_state_bloc.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/blocs/logger_bloc.dart';
import 'package:voxxedapp/blocs/speaker_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/screens/about_screen.dart';
import 'package:voxxedapp/screens/conference_detail.dart';
import 'package:voxxedapp/screens/conference_list.dart';
import 'package:voxxedapp/screens/speaker_detail.dart';
import 'package:voxxedapp/screens/speaker_list.dart';
import 'package:voxxedapp/screens/splash_screen.dart';

Future main() async {
  runApp(new VoxxedDayApp());
}

class VoxxedDayApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [
      LoggerBloc(),
      AppStateBloc(),
      ConferenceBloc(),
      SpeakerBloc(),
    ],
  );

  VoxxedDayApp() {
    // This will attempt to load a previously-saved app state from disk. A
    // request to the server for the list of conferences will automatically
    // follow. If both fail, the app can't run, and will halt on the splash
    // screen with a warning message.
    store.dispatcher(new LoadAppStateAction());
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');

    // Conference selector page.
    if (path[1] == 'conferences') {
      return new MaterialPageRoute<int>(
        builder: (context) => ConferenceListScreen(),
        settings: settings,
      );
    }

    // Details page for a single conference.
    if (path[1] == 'conference') {
      final id = int.parse(path[2]);
      return MaterialPageRoute(
        builder: (context) => ConferenceDetailScreen(id),
        settings: settings,
      );
    }

    // List of speakers for drill-down.
    if (path[1] == 'speakers') {
      return MaterialPageRoute(
        builder: (context) => SpeakerListScreen(),
        settings: settings,
      );
    }

    // List of speakers for drill-down.
    if (path[1] == 'speaker') {
      final uuid = path[2];
      return MaterialPageRoute(
        builder: (context) => SpeakerDetailScreen(uuid),
        settings: settings,
      );
    }

    // List of speakers for drill-down.
    if (path[1] == 'about') {
      return MaterialPageRoute(
        builder: (context) => AboutScreen(),
        settings: settings,
      );
    }

    // Must be time for the splash screen.
    return MaterialPageRoute(
      builder: (context) => SplashScreen(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}
