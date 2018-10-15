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

import 'package:rebloc/rebloc.dart';
import 'package:voxxedapp/models/app_state.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:voxxedapp/models/schedule_slot.dart';
import 'package:voxxedapp/util/logger.dart';

class ToggleFavoriteAction extends Action {
  final String talkId;

  ToggleFavoriteAction(this.talkId);
}

class SetAllNotificationsAction extends Action {}

class FavoritesBloc extends SimpleBloc<AppState> {
  FavoritesBloc() {
    var initializationSettings = new InitializationSettings(
      AndroidInitializationSettings('ic_session_start'),
      IOSInitializationSettings(),
    );

    _plugin.initialize(
      initializationSettings,
      selectNotification: _handleNotificationSelection,
    );
  }

  static final _notificationDetails = NotificationDetails(
    AndroidNotificationDetails(
        'voxxedapp_favorite_beginning',
        'Session Beginning',
        'Notifications that appear when a session marked as favorite is about '
        'to begin.'),
    IOSNotificationDetails(),
  );

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _handleNotificationSelection(String msg) async {
    log.info('Notification selection: $msg');
  }

  Future<void> _scheduleNotification(int id, ScheduleSlot slot) async {
    DateTime notificationTime =
        DateTime.fromMillisecondsSinceEpoch(slot.fromTimeMillis, isUtc: true)
            .subtract(Duration(minutes: 10));

    await _plugin.schedule(
      id,
      'Session starting',
      '${slot.talk.title} begins in ten minutes in ${slot.roomName}.',
      notificationTime,
      _notificationDetails,
    );
  }

  Future<void> _cancelNotification(int id) async {
    return await _plugin.cancel(id);
  }

  @override
  FutureOr<Action> middleware(
      DispatchFunction dispatcher, AppState state, Action action) {
    if (action is SetAllNotificationsAction) {
      for (final talkId in state.sessionNotifications.keys) {
        final slot = state.getSlotByTalkId(talkId);
        if (slot != null) {
          _scheduleNotification(state.sessionNotifications[talkId], slot);
        }
      }
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is ToggleFavoriteAction) {
      if (state.sessionNotifications.containsKey(action.talkId)) {
        _cancelNotification(state.sessionNotifications[action.talkId]);
        return state
            .rebuild((b) => b.sessionNotifications.remove(action.talkId));
      } else {
        final slot = state.getSlotByTalkId(action.talkId);
        if (slot != null) {
          final id = state.lastNotificationId + 1;
          _scheduleNotification(id, slot);
          return state.rebuild((b) => b
            ..sessionNotifications[action.talkId] = id
            ..lastNotificationId = b.lastNotificationId + 1);
        }
      }
    }

    return state;
  }
}
