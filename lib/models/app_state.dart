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
import 'package:voxxedapp/models/speaker.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  BuiltMap<int, Conference> get conferences;

  BuiltMap<int, BuiltList<Speaker>> get speakers;

  BuiltMap<int, BuiltList<Schedule>> get schedules;

  BuiltList<String> get favoriteSessions;

  int get selectedConferenceId;

  // TODO(redbrogdon): Replace these with some kind of enum.
  bool get readyToGo;

  bool get willNeverBeReadyToGo;

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  factory AppState.initialState() {
    return AppState((b) => b
      .._selectedConferenceId = 0
      ..readyToGo = false
      .._willNeverBeReadyToGo = false);
  }
}
