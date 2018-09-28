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

part 'schedule_break.g.dart';

abstract class ScheduleBreak implements Built<ScheduleBreak, ScheduleBreakBuilder> {
  static Serializer<ScheduleBreak> get serializer => _$scheduleBreakSerializer;

  static const listSerializationType =
  const FullType(BuiltList, [FullType(ScheduleBreak)]);

  String get id;

  String get nameEN;

  String get nameFR;

  String get room;

  ScheduleBreak._();

  factory ScheduleBreak([updates(ScheduleBreakBuilder b)]) = _$ScheduleBreak;
}
