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
import 'package:voxxedapp/models/schedule_slot.dart';

part 'schedule.g.dart';

abstract class Schedule implements Built<Schedule, ScheduleBuilder> {
  static Serializer<Schedule> get serializer => _$scheduleSerializer;

  static const listSerializationType =
      const FullType(BuiltList, [FullType(Schedule)]);

  String get day;

  String get title;

  BuiltList<ScheduleSlot> get slots;

  Schedule._();

  factory Schedule([updates(ScheduleBuilder b)]) = _$Schedule;
}
