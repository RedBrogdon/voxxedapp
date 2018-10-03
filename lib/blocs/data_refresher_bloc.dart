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

import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/blocs/navigation_bloc.dart';
import 'package:voxxedapp/blocs/speaker_bloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:rebloc/rebloc.dart';

/// This bloc listens for navigation-related actions and kicks off requests to
/// refresh data in response.
class DataRefresherBloc extends SimpleBloc<AppState> {
  @override
  FutureOr<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is DidPushNamedRouteAction) {
      var path = action.routeName.split('/');

      if (path[1] == 'conferences') {
        return action..afterward(RefreshConferencesAction());
      }

      // Details page for a single conference.
      if (path[1] == 'conference') {
        final conferenceId = int.parse(path[2]);

        if (path.length < 5) {
          return action..afterward(RefreshConferenceAction(conferenceId));
        }

        // List of speakers for drill-down.
        if (path[3] == 'speaker') {
          final uuid = path[4];
          return action
            ..afterward(RefreshSpeakerForConferenceAction(conferenceId, uuid));
        }
      }
    }

    return action;
  }
}
