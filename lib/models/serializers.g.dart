// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AppState.serializer)
      ..add(Conference.serializer)
      ..add(EventType.serializer)
      ..add(Language.serializer)
      ..add(Schedule.serializer)
      ..add(ScheduleBreak.serializer)
      ..add(ScheduleSlot.serializer)
      ..add(SessionType.serializer)
      ..add(Speaker.serializer)
      ..add(Talk.serializer)
      ..add(Track.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ScheduleSlot)]),
          () => new ListBuilder<ScheduleSlot>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Track)]),
          () => new ListBuilder<Track>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Language)]),
          () => new ListBuilder<Language>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SessionType)]),
          () => new ListBuilder<SessionType>())
      ..addBuilderFactory(
          const FullType(BuiltMap,
              const [const FullType(int), const FullType(Conference)]),
          () => new MapBuilder<int, Conference>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(BuiltList, const [const FullType(Speaker)])
          ]),
          () => new MapBuilder<int, BuiltList<Speaker>>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(int),
            const FullType(BuiltList, const [const FullType(Schedule)])
          ]),
          () => new MapBuilder<int, BuiltList<Schedule>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>()))
    .build();
