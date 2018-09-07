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

import 'package:built_collection/built_collection.dart';
import 'package:voxxedapp/data/conference_repository.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:rebloc/rebloc.dart';

/// Manage cached conference data:
class LoadCachedConferencesAction extends Action {}

class LoadedCachedConferencesAction extends Action {
  final List<Conference> conferences;

  const LoadedCachedConferencesAction(this.conferences);
}

class LoadCachedConferencesFailedAction extends Action {}

/// Refresh the entire conference list (partial data for each conference):
class RefreshConferencesAction extends Action {}

class RefreshedConferencesAction extends Action {
  final List<Conference> conferences;

  const RefreshedConferencesAction(this.conferences);
}

class RefreshConferencesFailedAction extends Action {}

/// Refresh a single conference:
class RefreshConferenceAction extends Action {
  final int id;
  const RefreshConferenceAction(this.id);
}

class RefreshedConferenceAction extends Action {
  final conferences;

  const RefreshedConferenceAction(this.conferences);
}

class RefreshConferenceFailedAction extends Action {}


/// Manages the loading and caching of conference records.
class ConferenceBloc extends SimpleBloc<AppState> {
  final ConferenceRepository repository;

  ConferenceBloc({this.repository = const ConferenceRepository()});

  Action _loadCachedConferences(DispatchFunction dispatcher, AppState state,
      LoadCachedConferencesAction action) {
    repository.loadCachedConferences().then((list) {
      dispatcher(new LoadedCachedConferencesAction(list.toList()));
    }).catchError((e, s) {
      dispatcher(LoadCachedConferencesFailedAction());
    });

    return action;
  }

  Action _refreshConferences(DispatchFunction dispatcher, AppState state,
      RefreshConferencesAction action) {
    repository.refreshConferences().then((newList) {
      dispatcher(RefreshedConferencesAction(newList.toList()));
    }).catchError((_) {
      dispatcher(RefreshConferencesFailedAction());
    });

    return action;
  }

  AppState _loadedCachedConferences(
      AppState state, LoadedCachedConferencesAction action) {
    AppState newState =
        state.rebuild((b) => b..conferences.replace(action.conferences));
    return newState
        .rebuild((b) => b..speakers.replace(_reconcileSpeakerLists(newState)));
  }

  AppState _refreshedConferences(
      AppState state, RefreshedConferencesAction action) {
    AppState newState =
        state.rebuild((b) => b..conferences.replace(action.conferences));
    return newState
        .rebuild((b) => b..speakers.replace(_reconcileSpeakerLists(newState)));
  }

  BuiltMap<int, BuiltList<Speaker>> _reconcileSpeakerLists(AppState state) {
    // IDs that are no longer in the list of conferences, so their corresponding
    // speaker lists should be removed.
    final staleIds = state.speakers.keys.toList()
      ..removeWhere((id) => state.conferences.any((c) => c.id == id));

    // New conference IDs for which speaker lists haven't yet been created.
    final newIds = state.conferences.map((c) => c.id).toList()
      ..removeWhere((id) => state.speakers.containsKey(id));

    // Add the new stuff and remove the stale.
    return state.speakers.rebuild((b) {
      b.addIterable(newIds, key: (i) => i, value: (_) => BuiltList<Speaker>());
      for (int staleId in staleIds) {
        b.remove(staleId);
      }
    });
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is LoadCachedConferencesAction) {
      _loadCachedConferences(dispatcher, state, action);
    } else if (action is RefreshConferencesAction) {
      _refreshConferences(dispatcher, state, action);
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is LoadedCachedConferencesAction) {
      return _loadedCachedConferences(state, action);
    } else if (action is RefreshedConferencesAction) {
      return _refreshedConferences(state, action);
    }

    return state;
  }
}
