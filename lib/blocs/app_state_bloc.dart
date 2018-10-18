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
import 'package:voxxedapp/blocs/navigation_bloc.dart';
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

class LoadColdAppStateAction extends Action {}

class ColdAppStateLoadedAction extends Action {
  final AppState state;

  ColdAppStateLoadedAction(this.state);
}

class ColdAppStateFailedToLoadAction extends Action {}

/// Manages the loading and caching of conference records.
class AppStateBloc extends SimpleBloc<AppState> {
  AppStateBloc({this.localStorage = const AppStateLocalStorage()});

  final AppStateLocalStorage localStorage;

  void _beginLoadingAppState(DispatchFunction dispatcher) {
    localStorage.loadAppStateFromCache().then((state) {
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

  void _beginLoadingColdAppState(DispatchFunction dispatcher) {
    localStorage.loadAppStateFromAsset().then((state) {
      if (state != null) {
        dispatcher(ColdAppStateLoadedAction(state));
      } else {
        dispatcher(ColdAppStateFailedToLoadAction());
      }
    }).catchError((e, s) {
      log.severe('Failed to load cold boot state asset: $e');
      dispatcher(ColdAppStateFailedToLoadAction());
    });
  }

  @override
  FutureOr<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is SaveAppStateAction) {
      localStorage.saveAppStateToCache(state);
    }

    if (action is LoadAppStateAction) {
      _beginLoadingAppState(dispatcher);
    }

    if (action is LoadColdAppStateAction) {
      _beginLoadingColdAppState(dispatcher);
    }

    if (action is LoadAppStateFailedAction) {
      // If loading a cached app state from disk has failed (e.g. this is the
      // first run, or an app update has rendered previous state unusable), try
      // loading app state from the cold boot json file.
      action.afterward(LoadColdAppStateAction());
    }

    if (action is AppStateLoadedAction ||
        action is ColdAppStateLoadedAction ||
        action is ColdAppStateFailedToLoadAction) {
      // Once the loading of app state from cache or asset has completed or
      // errored out, attempt to refresh data for all conferences from network.
      action.afterward(RefreshConferencesAction());
    }

    if (action is AppStateLoadedAction ||
        action is ColdAppStateLoadedAction ||
        action is RefreshedConferencesAction) {
      // Any of these three indicate that an app state has been loaded and the
      // splash screen, if open, should be closed.
      action.afterward(LeaveSplashScreenAction());
    }

    if (action is RefreshedConferenceAction ||
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
        ..launchTime = state.launchTime
        ..readyToGo = true
        ..willNeverBeReadyToGo = false);
    }

    if (action is ColdAppStateLoadedAction) {
      return action.state.rebuild((b) => b..launchTime = state.launchTime);
    }

    return state;
  }
}
