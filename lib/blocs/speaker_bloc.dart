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
import 'package:voxxedapp/blocs/conference_bloc.dart';
import 'package:voxxedapp/data/web_client.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/util/logger.dart';

class RefreshSpeakersForConferenceAction extends Action {
  final int conferenceId;

  RefreshSpeakersForConferenceAction(this.conferenceId);
}

class RefreshedSpeakersForConferenceAction extends Action {
  final BuiltList<Speaker> speakers;
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
  final WebClient webClient;

  SpeakerBloc({this.webClient = const WebClient()});

  Future<void> _refreshSpeakersForConference(DispatchFunction dispatch,
      AppState state, RefreshSpeakersForConferenceAction action) async {
    String cfpVersion = state.conferences[action.conferenceId]?.cfpVersion;
    String cfpUrl = state.conferences[action.conferenceId]?.cfpURL;

    if (cfpVersion == null || cfpUrl == null) {
      log.warning(
          'Couldn\'t refresh speakers for conference ${action.conferenceId}.');
    } else {
      try {
        final speakers = await webClient.fetchSpeakers(cfpUrl, cfpVersion);
        dispatch(RefreshedSpeakersForConferenceAction(
            speakers, action.conferenceId));
      } on WebClientException catch (e) {
        logException('_refreshSpeakersForConference', e.message);
        dispatch(RefreshSpeakersForConferenceFailedAction());
      }
    }
  }

  Future<void> _refreshSpeakerForConference(DispatchFunction dispatch,
      AppState state, RefreshSpeakerForConferenceAction action) async {
    String cfpVersion = state.conferences[action.conferenceId]?.cfpVersion;
    String cfpUrl = state.conferences[action.conferenceId]?.cfpURL;

    if (cfpVersion == null || cfpUrl == null) {
      log.warning('Couldn\'t refresh speaker ${action.uuid} for conference'
          ' #${action.conferenceId}.');
    } else {
      try {
        final speaker =
            await webClient.fetchSpeaker(cfpUrl, cfpVersion, action.uuid);
        dispatch(
            RefreshedSpeakerForConferenceAction(speaker, action.conferenceId));
      } on WebClientException catch (e) {
        logException('_refreshSpeakerForConference', e.message);
        dispatch(RefreshSpeakerForConferenceFailedAction());
      }
    }
  }

  AppState _refreshedSpeakersForConference(
      AppState state, RefreshedSpeakersForConferenceAction action) {
    if (state.speakers.containsKey(action.conferenceId)) {
      return state.rebuild(
        (cb) => cb
          ..speakers[action.conferenceId] = action.speakers.rebuild((b) {
            for (int i = 0; i < action.speakers.length; i++) {
              final oldSpeaker = state.speakers[action.conferenceId]
                  .firstWhere((s) => s.uuid == b[i].uuid, orElse: () => null);
              if (oldSpeaker != null) {
                b[i] = b[i].rebuild((sb) => sb
                  ..bio = oldSpeaker.bio
                  ..lang = oldSpeaker.lang
                  ..blog = oldSpeaker.blog);
              }
            }
          }),
      );
    }

    return state;
  }

  AppState _refreshedSpeakerForConference(
      AppState state, RefreshedSpeakerForConferenceAction action) {
    if (state.speakers.containsKey(action.conferenceId)) {
      final oldSpeaker = state.speakers[action.conferenceId]
          .firstWhere((s) => s.uuid == action.speaker.uuid, orElse: () => null);
      return state.rebuild(
        (b) => b
          ..speakers[action.conferenceId] =
              b.speakers[action.conferenceId].rebuild((sb) {
            if (oldSpeaker != null) {
              int index =
                  state.speakers[action.conferenceId].indexOf(oldSpeaker);
              sb[index] = action.speaker;
            } else {
              sb.add(action.speaker);
            }
          }),
      );
    }

    return state;
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshSpeakersForConferenceAction) {
      _refreshSpeakersForConference(dispatcher, state, action);
    }

    if (action is RefreshSpeakerForConferenceAction) {
      _refreshSpeakerForConference(dispatcher, state, action);
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

  @override
  FutureOr<Action> afterware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is RefreshedConferenceAction) {
      dispatcher(RefreshSpeakersForConferenceAction(action.conference.id));
    }

    return action;
  }
}
