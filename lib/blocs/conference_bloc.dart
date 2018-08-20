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
import 'package:voxxedapp/data/conference_repository.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/speaker.dart';
import 'package:voxxedapp/rebloc.dart';
import 'package:voxxedapp/util/logger.dart';

class LoadCachedConferencesAction extends Action {
  const LoadCachedConferencesAction();
}

class RefreshConferencesAction extends Action {
  const RefreshConferencesAction();
}

class RefreshedConferencesAction extends Action {
  final List<Conference> conferences;

  const RefreshedConferencesAction(this.conferences);
}

class LoadedCachedConferencesAction extends Action {
  final List<Conference> conferences;

  const LoadedCachedConferencesAction(this.conferences);
}

class ConferenceBloc extends Bloc<AppState> {
  final ConferenceRepository repository;

  ConferenceBloc({this.repository = const ConferenceRepository()});

  void _loadCachedConferences(MiddlewareContext<AppState> context,
      EventSink<MiddlewareContext<AppState>> sink) {
    repository.loadCachedConferences().then((list) {
      log.info('Adding ${list.length} cached items to stream.');
      context.dispatcher(new LoadedCachedConferencesAction(list.toList()));
    }).catchError((e, s) {
      log.warning('_loadCachedConferences failed.');
    });

    sink.add(context);
  }

  void _refreshConferences(MiddlewareContext<AppState> context,
      EventSink<MiddlewareContext<AppState>> sink) {
    repository.refreshConferences().then((newList) {
      context.dispatcher(RefreshedConferencesAction(newList.toList()));
      log.info('Refreshed ${newList?.length} conferences.');
    }).catchError((_) {
      log.warning('refreshConferences() failed.');
    });

    sink.add(context);
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
  Stream<MiddlewareContext<AppState>> applyMiddleware(
      Stream<MiddlewareContext<AppState>> input) {
    return input.transform(
      StreamTransformer.fromHandlers(
        handleData: (context, sink) {
          if (context.action is LoadCachedConferencesAction) {
            _loadCachedConferences(context, sink);
          } else if (context.action is RefreshConferencesAction) {
            _refreshConferences(context, sink);
          } else {
            sink.add(context);
          }
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
          if (accumulator.action is LoadedCachedConferencesAction) {
            newState =
                _loadedCachedConferences(accumulator.state, accumulator.action);
          } else if (accumulator.action is RefreshedConferencesAction) {
            newState =
                _refreshedConferences(accumulator.state, accumulator.action);
          }

          sink.add(accumulator.copyWith(newState));
        },
      ),
    );
  }
}
