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
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:voxxedapp/models/conference.dart';
import 'package:voxxedapp/models/schedule.dart';
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/models/speaker.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  BuiltMap<int, Conference> get conferences;

  BuiltMap<int, BuiltList<Speaker>> get speakers;

  BuiltMap<int, BuiltList<Schedule>> get schedules;

  // If a talkId is present as a key in this map, it is "favorited."
  BuiltMap<String, int> get sessionNotifications;

  int get lastNotificationId;

  int get selectedConferenceId;

  // TODO(redbrogdon): Replace these with some kind of enum.
  bool get readyToGo;

  bool get willNeverBeReadyToGo;

  // This field holds a rough approximation of the time (in milliseconds) at
  // which the app began executing. It's not serialized, since it shouldn't be
  // persisted between executions.
  @nullable
  @BuiltValueField(serialize: false)
  int get launchTime;

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  factory AppState.initialState() {
    return AppState((b) => b
      ..lastNotificationId = 0
      .._selectedConferenceId = 0
      ..launchTime = DateTime.now().millisecondsSinceEpoch
      ..readyToGo = false
      .._willNeverBeReadyToGo = false);
  }

  ScheduleSlot getSlot(String talkId) {
    for (final scheduleList in schedules.values) {
      for (final schedule in scheduleList) {
        final slot = schedule.slots
            .firstWhere((s) => s.talk?.id == talkId, orElse: () => null);
        if (slot != null) {
          return slot;
        }
      }
    }

    return null;
  }

  int getConferenceIdForTalkId(String talkId) {
    for (final conferenceId in schedules.keys) {
      for (final schedule in schedules[conferenceId]) {
        final slot = schedule.slots
            .firstWhere((s) => s.talk?.id == talkId, orElse: () => null);
        if (slot != null) {
          return conferenceId;
        }
      }
    }

    return null;
  }

  Speaker getSpeaker(int conferenceId, String uuid) {
    return speakers[conferenceId]?.firstWhere(
      (s) => s.uuid == uuid,
      orElse: () => null,
    );
  }
}
