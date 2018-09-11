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
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/data/speaker_repository.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/util/logger.dart';

class RefreshSpeakersForConferenceAction extends Action {
  final int conferenceId;

  RefreshSpeakersForConferenceAction(this.conferenceId);
}

class RefreshedSpeakersForConferenceAction extends Action {
  final List<Speaker> speakers;
  final int conferenceId;

  RefreshedSpeakersForConferenceAction(this.speakers, this.conferenceId);
}

class RefreshSpeakersForConferenceFailedAction extends Action {
  RefreshSpeakersForConferenceFailedAction();
}

class RefreshSpeakerForConferenceAction extends Action {
  final int conferenceId;
  final String uuid;

  RefreshSpeakerForConferenceAction(this.conferenceId, this.uuid);
}

class RefreshedSpeakerForConferenceAction extends Action {
  final Speaker speaker;
  final int conferenceId;

  RefreshedSpeakerForConferenceAction(this.speaker, this.conferenceId);
}

class RefreshSpeakerForConferenceFailedAction extends Action {
  RefreshSpeakerForConferenceFailedAction();
}

class SpeakerBloc extends SimpleBloc<AppState> {
  final SpeakerRepository repository;

  SpeakerBloc({this.repository = const SpeakerRepository()});

  Action _refreshSpeakersForConference(DispatchFunction dispatch,
      AppState state, RefreshSpeakersForConferenceAction action) {
    String cfpVersion = state.conferences[action.conferenceId]?.cfpVersion;
    String cfpUrl = state.conferences[action.conferenceId]?.cfpURL;

    if (cfpVersion == null || cfpUrl == null) {
      log.warning(
          'Couldn\'t refresh speakers for conference ${action.conferenceId}.');
    } else {
      repository.refreshSpeakers(cfpUrl, cfpVersion).then((newList) {
        dispatch(RefreshedSpeakersForConferenceAction(
            newList.toList(), action.conferenceId));
      }).catchError((_) {
        dispatch(RefreshSpeakersForConferenceFailedAction());
      });
    }

    return action;
  }

  Action _refreshSpeakerForConference(DispatchFunction dispatch, AppState state,
      RefreshSpeakerForConferenceAction action) {
    String cfpVersion = state.conferences[action.conferenceId]?.cfpVersion;
    String cfpUrl = state.conferences[action.conferenceId]?.cfpURL;

    if (cfpVersion == null || cfpUrl == null) {
      log.warning('Couldn\'t refresh speaker ${action.uuid} for conference'
          ' #${action.conferenceId}.');
    } else {
      repository
          .refreshSpeaker(cfpUrl, cfpVersion, action.uuid)
          .then((speaker) {
        dispatch(
            RefreshedSpeakerForConferenceAction(speaker, action.conferenceId));
      }).catchError((_) {
        dispatch(RefreshSpeakerForConferenceFailedAction());
      });
    }

    return action;
  }

  AppState _refreshedSpeakersForConference(
      AppState state, RefreshedSpeakersForConferenceAction action) {
    if (state.speakers.containsKey(action.conferenceId)) {
      return state.rebuild((b) => b
        ..speakers[action.conferenceId] = BuiltList<Speaker>(action.speakers));
    }

    return state;
  }

  AppState _refreshedSpeakerForConference(
      AppState state, RefreshedSpeakerForConferenceAction action) {
    if (state.speakers.containsKey(action.conferenceId)) {
      return state.rebuild(
        (b) => b
          ..speakers[action.conferenceId] = b.speakers[action.conferenceId].rebuild(
            (sb) => sb
              ..removeWhere((s) => s.uuid == action.speaker.uuid)
              ..add(action.speaker),
          ),
      );
    }

    return state;
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshSpeakersForConferenceAction) {
      return _refreshSpeakersForConference(dispatcher, state, action);
    } else if (action is RefreshSpeakerForConferenceAction) {
      return _refreshSpeakerForConference(dispatcher, state, action);
    } else if (action is RefreshedConferenceAction) {
      return action
        ..afterward(RefreshSpeakersForConferenceAction(action.conference.id));
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is RefreshedSpeakersForConferenceAction) {
      return _refreshedSpeakersForConference(state, action);
    } else if (action is RefreshedSpeakerForConferenceAction) {
      return _refreshedSpeakerForConference(state, action);
    }

    return state;
  }
}
