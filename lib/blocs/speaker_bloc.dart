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
import 'package:voxxedapp/data/speaker_repository.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/rebloc.dart';
import 'package:voxxedapp/util/logger.dart';

class LoadCachedSpeakersAction extends Action {
  const LoadCachedSpeakersAction();
}

class RefreshSpeakersForConferenceAction extends Action {
  final int conferenceId;

  const RefreshSpeakersForConferenceAction(this.conferenceId);
}

class RefreshedSpeakersForConferenceAction extends Action {
  final List<Speaker> speakers;
  final int conferenceId;

  const RefreshedSpeakersForConferenceAction(this.speakers, this.conferenceId);
}

class LoadedCachedSpeakersAction extends Action {
  final List<Speaker> speakers;

  const LoadedCachedSpeakersAction(this.speakers);
}

class SpeakerBloc extends Bloc<AppState> {
  final SpeakerRepository repository;

  SpeakerBloc({this.repository = const SpeakerRepository()});

  void _refreshSpeakersForConference(
      DispatchFunction dispatch,
      AppState state,
      RefreshSpeakersForConferenceAction action,
      EventSink<MiddlewareContext<AppState>> sink) {
    String cfpVersion = state.conferences
        .firstWhere((c) => c.id == action.conferenceId, orElse: () => null)
        ?.cfpVersion;

    if (cfpVersion == null) {
      log.warning('Couldn\'t refresh speakers for conference ${action
          .conferenceId}.');
    } else {
      repository.refreshSpeakers(cfpVersion).then((newList) {
        log.info('Refreshed ${newList?.length} speakers for conference ${action
            .conferenceId}.');
        dispatch(new RefreshedSpeakersForConferenceAction(
            newList.toList(), action.conferenceId));
      }).catchError((_) {
        log.warning('refreshSpeakers(${action.conferenceId}) failed.');
      });
    }
  }

  AppState _refreshedSpeakersForConference(
      AppState state, RefreshedSpeakersForConferenceAction action) {
    if (state.speakers.containsKey(action.conferenceId)) {
      return state.rebuild((b) => b
        ..speakers.addAll(
            {action.conferenceId: BuiltList<Speaker>(action.speakers)}));
    }

    return state;
  }

  @override
  Stream<MiddlewareContext<AppState>> applyMiddleware(
      Stream<MiddlewareContext<AppState>> input) {
    return input.transform(
      StreamTransformer.fromHandlers(
        handleData: (context, sink) {
          if (context.action is RefreshSpeakersForConferenceAction) {
            _refreshSpeakersForConference(
                context.dispatcher, context.state, context.action, sink);
          }

          sink.add(context);
        },
      ),
    );
  }

  @override
  Stream<Accumulator<AppState>> applyReducer(
      Stream<Accumulator<AppState>> input) {
    return input.transform(
      StreamTransformer.fromHandlers(
        handleData: (accumulator, sink) {
          AppState newState = accumulator.state;
          if (accumulator.action is RefreshedSpeakersForConferenceAction) {
            newState = _refreshedSpeakersForConference(
                accumulator.state, accumulator.action);
          }

          sink.add(accumulator.copyWith(newState));
        },
      ),
    );
  }
}
