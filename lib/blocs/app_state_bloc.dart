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

import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/blocs/favorites_bloc.dart';
import 'package:voxxedapp/blocs/schedule_bloc.dart';
import 'package:voxxedapp/blocs/speaker_bloc.dart';
import 'package:voxxedapp/data/app_state_local_storage.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/util/logger.dart';

class SaveAppStateAction extends Action {}

class LoadAppStateAction extends Action {}

class LoadAppStateFailedAction extends Action {}

class AppStateLoadedAction extends Action {
  final AppState state;

  AppStateLoadedAction(this.state);
}

/// Manages the loading and caching of conference records.
class AppStateBloc extends SimpleBloc<AppState> {
  final AppStateLocalStorage localStorage;

  AppStateBloc({this.localStorage = const AppStateLocalStorage()});

  void _beginLoadingAppState(DispatchFunction dispatcher) {
    localStorage.loadAppState().then((state) {
      if (state != null) {
        dispatcher(AppStateLoadedAction(state));
      } else {
        dispatcher(LoadAppStateFailedAction());
      }
    }).catchError((e, s) {
      log.warning('Error while loading app state from disk: $e');
      dispatcher(LoadAppStateFailedAction());
    });
  }

  @override
  FutureOr<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is SaveAppStateAction) {
      localStorage.saveAppState(state);
    } else if (action is LoadAppStateAction) {
      _beginLoadingAppState(dispatcher);
    } else if (action is LoadAppStateFailedAction ||
        action is AppStateLoadedAction) {
      dispatcher(RefreshConferencesAction());
    } else if (action is RefreshedConferenceAction ||
        action is RefreshedConferencesAction ||
        action is RefreshedSpeakersForConferenceAction ||
        action is RefreshedSpeakerForConferenceAction ||
        action is RefreshedSchedulesAction ||
        action is RefreshedScheduleSlotsAction ||
        action is ToggleFavoriteAction) {
      // New data is arriving, so app state should be saved afterward.
      action.afterward(SaveAppStateAction());
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    // If there were no cached app state, this is the fallback to readiness.
    if (action is RefreshedConferencesAction) {
      return state.rebuild((b) => b..readyToGo = true);
    }

    if (action is RefreshConferencesFailedAction) {
      if (!state.readyToGo) {
        log.severe('Failed to refresh conferences with no cached data!');
        return state.rebuild((b) => b..willNeverBeReadyToGo = true);
      }
    }

    if (action is AppStateLoadedAction) {
      return action.state.rebuild((b) => b
        ..readyToGo = true
        ..willNeverBeReadyToGo = false);
    }

    return state;
  }
}
