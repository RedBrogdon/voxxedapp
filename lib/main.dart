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
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/data/conference_repository.dart';
import 'package:voxxedapp/data/speaker_repository.dart';
import 'package:voxxedapp/screens/conference_detail.dart';
import 'package:voxxedapp/screens/conference_list.dart';

Future main() async {
  runApp(new VoxxedDayApp());
}

class VoxxedDayApp extends StatelessWidget {
  final conferencesBloc =
      ConferenceBloc(ConferenceRepository(), SpeakerRepository());

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');

    if (path[1] == 'conference') {
      final id = int.parse(path[2]);
      return MaterialPageRoute(
        builder: (context) => ConferenceDetailScreen(id),
        settings: settings,
      );
    }

    // Default route is the conference list.
    return new MaterialPageRoute(
      builder: (context) => ConferenceListScreen(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConferenceBlocProvider(
      conferenceBloc: conferencesBloc,
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
