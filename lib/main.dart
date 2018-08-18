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

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/blocs/logger_bloc.dart';
import 'package:voxxedapp/data/conference_repository.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/rebloc.dart';
import 'package:voxxedapp/screens/conference_detail.dart';
import 'package:voxxedapp/screens/conference_list.dart';

class ConferenceDetailsViewModel extends ViewModel<AppState, AppStateBuilder> {
  final Conference conference;
  final BuiltList<Speaker> speakers;

  const ConferenceDetailsViewModel._(
      Store<AppState, AppStateBuilder> store, this.conference, this.speakers)
      : super(store);

  factory ConferenceDetailsViewModel.fromAppState(
      Store<AppState, AppStateBuilder> store,
      AppState state,
      int conferenceId) {
    return ConferenceDetailsViewModel._(
        store,
        state.conferences
            .firstWhere((c) => c.id == conferenceId, orElse: () => null),
        state.speakers.containsKey(conferenceId)
            ? state.speakers[conferenceId]
            : BuiltList<Speaker>());
  }
}

Future main() async {
  runApp(new VoxxedDayApp());
}

class VoxxedDayApp extends StatelessWidget {
  final Store<AppState, AppStateBuilder> store =
      Store<AppState, AppStateBuilder>(
    initialState: AppState.initialState(),
    blocs: [
      LoggerBloc(),
      ConferenceBloc(ConferenceRepository()),
    ],
  );

  VoxxedDayApp() {
    store.states.listen((s) => print('STATE EMITTED: $s'));
    store.dispatch(new LoadCachedConferencesAction());
  }

  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
    var path = settings.name.split('/');

//    if (path[1] == 'conference') {
//      final id = int.parse(path[2]);
//      return MaterialPageRoute(
//        builder: (context) => ConferenceDetailScreen(id),
//        settings: settings,
//      );
//    }

    // Default route is the conference list.
    return new MaterialPageRoute(
      builder: (context) => ConferenceListScreen(),
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
      )
//      MaterialApp(
//        title: 'Flutter Demo',
//        theme: ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        home: Scaffold(
//          appBar: AppBar(title: Text('Hey there')),
//          body: Center(
//            child: ViewModelSubscriber<AppState, AppStateBuilder,
//                ConferenceDetailsViewModel>(
//              store: store,
//              stream: store.states,
//              converter: (store, state) =>
//                  ConferenceDetailsViewModel.fromAppState(store, state, 32),
//              builder: (context, viewModel) =>
//                  Text('${viewModel.conference?.id ?? 100}'),
//            ),
//          ),
//        ),
//      ),
    );
  }
}

//class VoxxedDayApp extends StatelessWidget {
//  final conferencesBloc =
//      ConferenceBloc(ConferenceRepository(), SpeakerRepository());
//
//  MaterialPageRoute _onGenerateRoute(RouteSettings settings) {
//    var path = settings.name.split('/');
//
//    if (path[1] == 'conference') {
//      final id = int.parse(path[2]);
//      return MaterialPageRoute(
//        builder: (context) => ConferenceDetailScreen(id),
//        settings: settings,
//      );
//    }
//
//    // Default route is the conference list.
//    return new MaterialPageRoute(
//      builder: (context) => ConferenceListScreen(),
//      settings: settings,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ConferenceBlocProvider(
//      conferenceBloc: conferencesBloc,
//      child: MaterialApp(
//        title: 'Flutter Demo',
//        theme: ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        onGenerateRoute: _onGenerateRoute,
//      ),
//    );
//  }
//}
