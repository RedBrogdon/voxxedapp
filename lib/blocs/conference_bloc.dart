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
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voxxedapp/data/conference_repository.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/data/speaker_repository.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/util/logger.dart';

class ConferenceBloc {
  final ConferenceRepository _conferenceRepo;
  final SpeakerRepository _speakerRepo;

  final _conferences = BehaviorSubject<BuiltList<Conference>>();

  final _speakersByConference = Map<int, BehaviorSubject<BuiltList<Speaker>>>();

  var _selectedConferenceId = 0;

  ConferenceBloc(this._conferenceRepo, this._speakerRepo) {
    _loadCachedConferences();
    refreshConferences();
  }

  Observable<BuiltList<Conference>> get conferences => _conferences.stream;

  Observable<BuiltList<Speaker>> get speakersForSelectedConference =>
      _speakersByConference[_selectedConferenceId] ??
      BehaviorSubject<BuiltList<Speaker>>();

  Conference _getConference(int id) => _conferences.value
      .firstWhere((c) => c.id == id, orElse: () => null);

  Future<void> refreshConferences() async {
    try {
      final newList = await _conferenceRepo.refreshConferences();
      log.info('Adding ${newList?.length} refreshed items to stream.');
      _conferences.add(newList);
      await _reconcileSpeakerLists();
    } on Exception {
      //TODO(redbrogdon): Make this more specific.
      log.warning('refreshConferences() failed.');
    }
  }

  Future<void> refreshSpeakers(int id) async {
    try {
      String cfpVersion = _conferences.value
          .firstWhere((c) => c.id == id, orElse: () => null)
          ?.cfpVersion;
      if (cfpVersion == null) {
        log.warning('Couldn' 't refresh speakers for conference $id.');
        return;
      }

      final newList = await _speakerRepo.refreshSpeakers(cfpVersion);
      log.info('Refreshed ${newList?.length} speakers for conference $id.');
      _speakersByConference[id].add(newList);
    } on Exception {
      //TODO(redbrogdon): Make this more specific.
      log.warning('refreshSpeakers($id) failed.');
    }
  }

  Future<void> selectConference(int id) async {
    if (!_conferences.value.any((c) => c.id == id)) {
      log.warning('Failed to set selected conference to $id.');
      return;
    }

    _selectedConferenceId = id;
    await refreshSpeakers(id);
  }

  Future<void> _reconcileSpeakerLists() async {
    // Close and remove old speaker lists streams from the map.
    final oldConferenceIds = _speakersByConference.keys.toList();
    for (int oldId in oldConferenceIds) {
      if (!_conferences.value.any((c) => c.id == oldId)) {
        _speakersByConference[oldId].close();
        _speakersByConference.remove(oldId);
      }
    }

    // Add new speaker list streams for any conferences that don't already have
    // one.
    for (Conference conference in _conferences.value) {
      if (!_speakersByConference.containsKey(conference.id)) {
        _speakersByConference[conference.id] =
            BehaviorSubject<BuiltList<Speaker>>();
      }
    }
  }

  Future<void> _loadCachedConferences() async {
    try {
      final newList = await _conferenceRepo.loadCachedConferences();
      log.info('Adding ${newList?.length} cached items to stream.');
      _conferences.add(newList);
      _reconcileSpeakerLists();
    } on Exception {
      log.warning('_loadCachedConferences failed.');
    }
  }
}

class ConferenceBlocProvider extends InheritedWidget {
  final ConferenceBloc _bloc;

  ConferenceBlocProvider({
    Key key,
    @required ConferenceBloc conferenceBloc,
    Widget child,
  })  : _bloc = conferenceBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ConferenceBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ConferenceBlocProvider)
              as ConferenceBlocProvider)
          ._bloc;
}
