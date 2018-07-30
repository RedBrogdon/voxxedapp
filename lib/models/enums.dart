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

part 'enums.g.dart';

class EventType extends EnumClass {
  static Serializer<EventType> get serializer => _$eventTypeSerializer;

  static const EventType VOXXED = _$VOXXED;
  static const EventType DEVOXX = _$DEVOXX;

  const EventType._(String name) : super(name);

  static BuiltSet<EventType> get values => _$values;
  static EventType valueOf(String name) => _$valueOf(name);
}