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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

const EventType _$VOXXED = const EventType._('VOXXED');
const EventType _$DEVOXX = const EventType._('DEVOXX');

EventType _$valueOf(String name) {
  switch (name) {
    case 'VOXXED':
      return _$VOXXED;
    case 'DEVOXX':
      return _$DEVOXX;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EventType> _$values = new BuiltSet<EventType>(const <EventType>[
  _$VOXXED,
  _$DEVOXX,
]);

Serializer<EventType> _$eventTypeSerializer = new _$EventTypeSerializer();

class _$EventTypeSerializer implements PrimitiveSerializer<EventType> {
  @override
  final Iterable<Type> types = const <Type>[EventType];
  @override
  final String wireName = 'EventType';

  @override
  Object serialize(Serializers serializers, EventType object,
          {FullType specifiedType: FullType.unspecified}) =>
      object.name;

  @override
  EventType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      EventType.valueOf(serialized as String);
}
