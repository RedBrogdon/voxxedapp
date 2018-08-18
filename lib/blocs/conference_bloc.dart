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

import 'package:voxxedapp/data/conference_repository.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/rebloc.dart';

class LoadCachedConferencesAction extends Action {
  const LoadCachedConferencesAction();
}

class RefreshConferencesAction extends Action {
  final int id;

  const RefreshConferencesAction(this.id);
}

class RefreshedConferencesAction extends Action {
  final List<Conference> conferences;

  const RefreshedConferencesAction(this.conferences);
}

class LoadedCachedConferencesAction extends Action {
  final List<Conference> conferences;

  const LoadedCachedConferencesAction(this.conferences);
}

class ConferenceBloc extends Bloc<AppState, AppStateBuilder> {
  final ConferenceRepository repository;

  ConferenceBloc(this.repository);

  bool _loadCachedConferences(
      Store<AppState, AppStateBuilder> store, Action action) {
    return true;
  }

  bool _refreshSpeakersForConference(
      Store<AppState, AppStateBuilder> store, Action action) {
    return true;
  }

  AppStateBuilder _loadedCachedConferences(
      Store<AppState, AppStateBuilder> store,
      AppState state,
      LoadedCachedConferencesAction action) {
    return store.states.value.toBuilder();
  }

  AppStateBuilder _refreshedConferences(Store<AppState, AppStateBuilder> store,
      AppState state, RefreshedConferencesAction action) {
    return store.states.value.toBuilder();
  }

  @override
  AppStateBuilder reduce(
      Store<AppState, AppStateBuilder> store, AppState state, Action action) {
    if (action is LoadedCachedConferencesAction) {
      return _loadedCachedConferences(store, state, action);
    } else if (action is RefreshedConferencesAction) {
      return _refreshedConferences(store, state, action);
    }

    // Make no changes.
    return store.states.value.toBuilder();
  }

  @override
  bool middle(Store<AppState, AppStateBuilder> store, Action action) {
    if (action is LoadCachedConferencesAction) {
      return _loadCachedConferences(store, action);
    } else if (action is RefreshConferencesAction) {
      return _refreshSpeakersForConference(store, action);
    }

    // Keep going with the next middleware.
    return true;
  }
}

//class ConferenceBloc extends Store<AppState> {
//  final ConferenceRepository _conferenceRepo;
//  final SpeakerRepository _speakerRepo;
//
////  final appStates =
////      BehaviorSubject<AppState>(seedValue: AppState.initialState());
////
////  AppState get _state => appStates.value;
//
//  Conference get _selectedConference =>
//      _state.conferences.firstWhere((c) => c.id == _state.selectedConferenceId,
//          orElse: () => null);
//
//  ConferenceBloc(this._conferenceRepo, this._speakerRepo) {
//    _loadCachedConferences();
//    refreshConferences();
//  }
//
//  Future<void> refreshConferences() async {
//    try {
//      final newList = await _conferenceRepo.refreshConferences();
//      log.info('Adding ${newList?.length} refreshed items to stream.');
//      appStates.add(_state.rebuild((b) => b..conferences.replace(newList)));
//      await _reconcileSpeakerLists();
//    } on Exception {
//      //TODO(redbrogdon): Make this more specific.
//      log.warning('refreshConferences() failed.');
//    }
//  }
//
//  Future<void> refreshSpeakers(int id) async {
//    try {
//      String cfpVersion = _selectedConference.cfpVersion;
//
//      if (cfpVersion == null) {
//        log.warning('Couldn' 't refresh speakers for conference $id.');
//        return;
//      }
//
//      final newList = await _speakerRepo.refreshSpeakers(cfpVersion);
//      log.info('Refreshed ${newList?.length} speakers for conference $id.');
//
//      appStates.add(
//        _state.rebuild(
//          (b) => b.speakers.addAll({
//                id: newList,
//              }),
//        ),
//      );
//    } on Exception {
//      //TODO(redbrogdon): Make this more specific.
//      log.warning('refreshSpeakers($id) failed.');
//    }
//  }
//
//  Future<void> selectConference(int id) async {
//    if (!_state.conferences.any((c) => c.id == id)) {
//      log.warning('Failed to set selected conference to $id.');
//      return;
//    }
//
//    appStates.add(_state.rebuild((b) => b..selectedConferenceId = id));
//    await refreshSpeakers(id);
//  }
//
//  // Updates the map of speaker lists to match the current state of the list of
//  // conferences. If a conference used to exist and now does not, this method
//  // will remove its speaker list. If a new conference has been found, a new,
//  // empty list of speakers will be created.
//  Future<void> _reconcileSpeakerLists() async {
//    // IDs that are no longer in the list of conferences, so their corresponding
//    // speaker lists should be removed.
//    final staleIds = _state.speakers.keys.toList()
//      ..removeWhere((id) => _state.conferences.any((c) => c.id == id));
//
//    // New conference IDs for which speaker lists haven't yet been created.
//    final newIds = _state.conferences.map((c) => c.id).toList()
//      ..removeWhere((id) => _state.speakers.containsKey(id));
//
//    // Add the new stuff and remove the stale.
//    appStates.add(_state.rebuild((b) {
//      b.speakers.addIterable(newIds,
//          key: (i) => i, value: (_) => BuiltList<Speaker>());
//      for (int staleId in staleIds) {
//        b.speakers.remove(staleId);
//      }
//    }));
//  }
//
//  Future<void> _loadCachedConferences() async {
//    try {
//      final newList = await _conferenceRepo.loadCachedConferences();
//      log.info('Adding ${newList?.length} cached items to stream.');
//
//      appStates.add(_state.rebuild((b) => b..conferences.replace(newList)));
//    } on Exception {
//      log.warning('_loadCachedConferences failed.');
//    }
//  }
//}
//
//class ConferenceBlocProvider extends InheritedWidget {
//  final ConferenceBloc _bloc;
//
//  ConferenceBlocProvider({
//    Key key,
//    @required ConferenceBloc conferenceBloc,
//    Widget child,
//  })  : _bloc = conferenceBloc,
//        super(key: key, child: child);
//
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) => true;
//
//  static ConferenceBloc of(BuildContext context) =>
//      (context.inheritFromWidgetOfExactType(ConferenceBlocProvider)
//              as ConferenceBlocProvider)
//          ._bloc;
//}
