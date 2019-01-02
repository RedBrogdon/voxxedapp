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
import 'package:voxxedapp/models/schedule.dart';
import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/util/logger.dart';

class RefreshSchedulesAction extends Action {
  final int conferenceId;

  RefreshSchedulesAction(this.conferenceId);
}

class RefreshedSchedulesAction extends Action {
  final BuiltList<Schedule> schedules;
  final int conferenceId;

  RefreshedSchedulesAction(this.schedules, this.conferenceId);
}

class RefreshSchedulesFailedAction extends Action {
  RefreshSchedulesFailedAction();
}

class RefreshScheduleSlotsAction extends Action {
  final int conferenceId;
  final String day;

  RefreshScheduleSlotsAction(this.conferenceId, this.day);
}

class RefreshedScheduleSlotsAction extends Action {
  final BuiltList<ScheduleSlot> slots;
  final String day;
  final int conferenceId;

  RefreshedScheduleSlotsAction(this.slots, this.conferenceId, this.day);
}

class RefreshScheduleSlotsFailedAction extends Action {
  RefreshScheduleSlotsFailedAction();
}

class ScheduleBloc extends SimpleBloc<AppState> {
  final WebClient webClient;

  ScheduleBloc({this.webClient = const WebClient()});

  Future<void> _refreshSchedules(DispatchFunction dispatcher, AppState state,
      RefreshSchedulesAction action) async {
    String cfpVersion = state.conferences[action.conferenceId]?.cfpVersion;
    String cfpUrl = state.conferences[action.conferenceId]?.cfpURL;

    if (cfpVersion == null || cfpUrl == null) {
      log.warning(
          'Couldn\'t refresh schedules for conference ${action.conferenceId}.');
    } else {
      try {
        final schedules = await webClient.fetchSchedules(cfpUrl, cfpVersion);
        dispatcher(RefreshedSchedulesAction(schedules, action.conferenceId));
      } on WebClientException catch (e) {
        logException('_refreshSchedules', e.message);
        dispatcher(RefreshSchedulesFailedAction());
      }
    }
  }

  Future<void> _refreshScheduleSlots(DispatchFunction dispatcher,
      AppState state, RefreshScheduleSlotsAction action) async {
    String cfpVersion = state.conferences[action.conferenceId]?.cfpVersion;
    String cfpUrl = state.conferences[action.conferenceId]?.cfpURL;

    if (cfpVersion == null || cfpUrl == null) {
      log.warning('Couldn\'t refresh schedule for conference'
          ' #${action.conferenceId}.');
    } else {
      try {
        final slots =
            await webClient.fetchScheduleSlots(cfpUrl, cfpVersion, action.day);
        dispatcher(RefreshedScheduleSlotsAction(
            slots, action.conferenceId, action.day));
      } on WebClientException catch (e) {
        logException('_refreshScheduleSlots', e.message);
        dispatcher(RefreshScheduleSlotsFailedAction());
      }
    }

    return action;
  }

  AppState _refreshedSchedules(
      AppState state, RefreshedSchedulesAction action) {
    if (state.schedules.containsKey(action.conferenceId)) {
      final newList = <Schedule>[];

      return state.rebuild((b) {
        for (final newSched in action.schedules) {
          Schedule oldSched = b.schedules[action.conferenceId]
              .firstWhere((s) => s.day == newSched.day, orElse: () => null);
          if (oldSched != null) {
            newList.add(
                newSched.rebuild((ns) => ns.slots.replace(oldSched.slots)));
          } else {
            newList.add(newSched);
          }
        }

        b.schedules[action.conferenceId] = BuiltList<Schedule>(newList);
      });
    }

    return state;
  }

  AppState _refreshedScheduleSlots(
      AppState state, RefreshedScheduleSlotsAction action) {
    if (state.schedules.containsKey(action.conferenceId)) {
      Schedule sched = state.schedules[action.conferenceId]
          .firstWhere((s) => s.day == action.day, orElse: () => null);
      if (sched != null) {
        int index = state.schedules[action.conferenceId].indexOf(sched);
        AppState newState = state.rebuild((b) {
          b.schedules[action.conferenceId] =
              b.schedules[action.conferenceId].rebuild((sb) {
            sb[index] = sb[index].rebuild(
              (sbb) => sbb.slots.replace(action.slots),
            );
          });
        });

        return newState;
      }
    }

    return state;
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshSchedulesAction) {
      _refreshSchedules(dispatcher, state, action);
    }

    if (action is RefreshScheduleSlotsAction) {
      _refreshScheduleSlots(dispatcher, state, action);
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is RefreshedSchedulesAction) {
      return _refreshedSchedules(state, action);
    }

    if (action is RefreshedScheduleSlotsAction) {
      return _refreshedScheduleSlots(state, action);
    }

    return state;
  }

  @override
  FutureOr<Action> afterware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is RefreshedConferenceAction) {
      dispatcher(RefreshSchedulesAction(action.conference.id));
    }

    if (action is RefreshedSchedulesAction) {
      for (final schedule in action.schedules) {
        dispatcher(
            RefreshScheduleSlotsAction(action.conferenceId, schedule.day));
      }
    }

    return action;
  }
}
