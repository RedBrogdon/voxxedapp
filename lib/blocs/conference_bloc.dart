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

import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/rebloc.dart';

class LoadCachedConferencesAction extends Action {
  const LoadCachedConferencesAction();
}

class RefreshSpeakersForConferenceAction extends Action {
  final int id;

  const RefreshSpeakersForConferenceAction(this.id);
}

class CachedConferencesLoaded extends Action {
  final List<Conference> conferences;

  const CachedConferencesLoaded(this.conferences);
}

class ConBloc extends Bloc<AppState, AppStateBuilder> {
  ConBloc();

  Future<bool> _loadCachedConferences(
      Sink<Action> dispatch, AppState state, Action action) async {
    return true;
  }

  Future<bool> _refreshSpeakersForConference(
      Sink<Action> dispatch, AppState state, Action action) async {
    return true;
  }

  AppStateBuilder _loadedCachedConferences(
      AppState state, LoadCachedConferencesAction action) {
    return state.toBuilder();
  }

  AppStateBuilder _refreshedSpeakersConferences(AppState state, Action action) {
    return state.toBuilder();
  }

  @override
  Map<Type, Future<bool> Function(Sink<Action>, AppState, Action)>
      get middleware {
    return {
      LoadCachedConferencesAction: _loadCachedConferences,
      RefreshSpeakersForConferenceAction: _refreshSpeakersForConference,
    };
  }

  @override
  Map<Type, AppStateBuilder Function(AppState, Action)> get reducers {
    return {
      CachedConferencesLoaded: _loadedCachedConferences,
      RefreshSpeakersForConferenceAction: _refreshedSpeakersConferences,
    };
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
